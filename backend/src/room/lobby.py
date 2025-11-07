import logging
from typing import Callable, OrderedDict
from uuid import UUID

from code_store import RoomCodeStore
from protobuf.websocket_pb2 import ClientToServerMessage, LobbyUpdatedMessage, PlayerUpdatedMessage, ServerToClientMessage
from room.base import BaseRoom

logger = logging.getLogger(__name__)

class Player:
    def __init__(self, client_id: UUID, username: str):
        self.client_id = client_id
        self.username = username

class LobbyRoom(BaseRoom):
    def __init__(
            self,
            room_id: UUID,
            code_store: RoomCodeStore,
            *,
            replace_room: Callable[[BaseRoom], None],
    ):
        super().__init__()
        print("Creating LobbyRoom with id:", room_id)
        self.room_code = code_store.get_unique_code()
        self._room_id = room_id
        self._code_store = code_store
        self._replace_room = replace_room

        self.players: OrderedDict[UUID, Player] = OrderedDict()

    def __del__(self):
        self._code_store.release_code(self.room_code)

    async def disconnect(self, client_id: UUID):
        await super().disconnect(client_id)
        self.players.pop(client_id, None) # Remove player on disconnect
        await self._broadcast_lobby_update()

    async def process_message(self, client_id: UUID, message: ClientToServerMessage):
        match message.WhichOneof("payload"):
            case "player_updated":
                await self._handle_player_update(client_id, message.player_updated)

    async def _handle_player_update(self, client_id: UUID, message: PlayerUpdatedMessage):
        player = self.players.get(client_id)
        if player is None:
            player = Player(client_id, message.username)
            self.players[client_id] = player
        else:
            player.username = message.username
        await self._broadcast_lobby_update()

    async def _broadcast_lobby_update(self):
        await self.broadcast_message(
            ServerToClientMessage(
                lobby_updated=LobbyUpdatedMessage(
                    room_code=self.room_code,
                    usernames=[p.username for p in self.players.values()],
                )
            )
        )

import logging
from typing import Callable
from uuid import UUID, uuid4

from fastapi import WebSocket

from code_store import RoomCodeStore
from protobuf.websocket_pb2 import ClientToServerMessage, GameStartedMessage, LobbyUpdatedMessage, ServerToClientMessage
from room.base import BaseRoom, PlayerInfo

logger = logging.getLogger(__name__)


class LobbyRoom(BaseRoom):
    def __init__(
        self,
        code_store: RoomCodeStore,
        *,
        on_start_game: Callable[[dict[UUID, PlayerInfo], UUID], None],
    ):
        super().__init__()
        self.room_code = code_store.get_unique_code()
        self.player_info: dict[UUID, PlayerInfo] = {}
        self._code_store = code_store
        self._on_start_game = on_start_game

    def __del__(self):
        self._code_store.release_code(self.room_code)

    async def connect(self, client_id: UUID, player_name: str, websocket: WebSocket):
        await super().connect(client_id, websocket)
        self.player_info[client_id] = PlayerInfo(player_name=player_name)
        await self._broadcast_lobby_update()

    async def disconnect(self, client_id: UUID):
        await super().disconnect(client_id)
        self.player_info.pop(client_id, None) # Remove player on disconnect
        await self._broadcast_lobby_update()

    async def process_message(self, client_id: UUID, message: ClientToServerMessage):
        match message.WhichOneof("payload"):
            case "start_game":
                await self._handle_game_start(client_id)

    async def _handle_game_start(self, client_id: UUID):
        if list(self.active_connections.keys())[0] != client_id:
            logger.warning(f"Client {client_id} attempted to start game but is not host")
            return
        game_room_id = uuid4()
        self._on_start_game(dict(self.player_info), game_room_id)
        await self.broadcast_message(
            ServerToClientMessage(
                game_started=GameStartedMessage(
                    game_room_id=str(game_room_id)
                )
            )
        )

    async def _broadcast_lobby_update(self):
        for i, client_id in enumerate(self.active_connections.keys()):
            await self.send_message(
                client_id,
                ServerToClientMessage(
                    lobby_updated=LobbyUpdatedMessage(
                        room_code=self.room_code,
                        player_names=[p.player_name for p in self.player_info.values()],
                        is_host=(i == 0), # First player is host
                    )
                )
            )

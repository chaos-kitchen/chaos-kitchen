from collections import OrderedDict
from dataclasses import dataclass
from datetime import datetime, timedelta
import logging
from typing import Callable
from uuid import UUID

from fastapi import HTTPException, WebSocket

from code_store import RoomCodeStore
from protobuf.websocket_pb2 import (
    ClientToServerMessage,
    GameStartedMessage,
    LobbyUpdatedMessage,
    PlayerRole,
    ServerToClientMessage,
)
from utils import Timer

logger = logging.getLogger(__name__)


@dataclass
class PlayerInfo:
    player_name: str
    role: PlayerRole
    websocket: WebSocket | None


class GameRoom:
    def __init__(
        self, room_code_store: RoomCodeStore, remove_self_from_rooms: Callable
    ):
        super().__init__()
        self.players: OrderedDict[UUID, PlayerInfo] = OrderedDict()

        self.room_code: str | None = room_code_store.get_unique_code()
        self._room_code_store = room_code_store

        self.game_ends_at = datetime.min

        # Note: initialize game end timer, but don't start it yet
        self._game_end_timer = Timer(
            timedelta(minutes=5),
            callback=self._handle_game_timer_end,
        )
        self._room_deletion_timer = Timer(
            timedelta(minutes=30),
            callback=lambda: self._shutdown(),
        )
        self._room_deletion_timer.start()
        self._remove_self_from_rooms = remove_self_from_rooms

    @property
    def has_started(self) -> bool:
        return self.room_code is None

    @property
    def host_client_id(self) -> UUID | None:
        if not self.players:
            return None
        return next(iter(self.players.keys()))

    async def connect(self, client_id: UUID, player_name: str, websocket: WebSocket):
        # Player trying to join after game started
        print("Connecting:", client_id, player_name, self.room_code, self.has_started)
        if self.has_started and client_id not in self.players:
            raise HTTPException(status_code=403, detail="Game has already started")

        # Edge case: player connecting twice
        if client_id in self.players and (ws := self.players[client_id].websocket):
            logger.warning(
                f"Client {client_id} reconnected, closing previous connection"
            )
            await ws.close()

        # New player joining before game started
        if client_id not in self.players:
            self.players[client_id] = PlayerInfo(
                player_name="",
                role=PlayerRole.PLAYER_ROLE_UNSPECIFIED,
                websocket=None,
            )

        # Update player info + accept connection
        player = self.players[client_id]
        player.player_name = player_name
        player.websocket = websocket
        await websocket.accept()

        if self.has_started:
            # Game already started - send game started message
            await self._send_message(
                client_id,
                ServerToClientMessage(
                    game_started=GameStartedMessage(
                        role=player.role,
                        end_time=self.game_ends_at,
                    )
                ),
            )
        else:
            await self._broadcast_lobby_update()

    async def disconnect(self, client_id: UUID):
        assert client_id in self.players

        if self.has_started:
            # Mark player as disconnected
            self.players[client_id].websocket = None
        else:
            # Remove player from game
            self.players.pop(client_id)

    async def receive_message(self, client_id: UUID, websocket: WebSocket):
        client_data = await websocket.receive_bytes()
        client_message = ClientToServerMessage()
        client_message.ParseFromString(client_data)

        match client_message.WhichOneof("payload"):
            case "start_game":
                await self._handle_game_start(client_id)

    def _handle_game_timer_end(self):
        logger.info("Game ended due to timer expiration.")
        pass

    async def _handle_game_start(self, client_id: UUID):
        if client_id != self.host_client_id:
            logger.warning(
                f"Client {client_id} attempted to start game but is not host"
            )
            return

        assert self.room_code
        self._room_code_store.release_code(self.room_code)
        self.room_code = None

        self.game_ends_at = datetime.now() + timedelta(minutes=5)

        assert not self._game_end_timer.is_running
        self._game_end_timer.start()
        self._room_deletion_timer.restart()

        # FIXME: ensure exactly 2 players are connected
        # FIXME: Randomize roles later
        assert len(self.players) >= 1
        for client_id, player in self.players.items():
            player.role = (
                PlayerRole.PLAYER_ROLE_COOK
                if player.player_name.lower() == "cook"
                else PlayerRole.PLAYER_ROLE_INSTRUCTOR
            )
            await self._send_message(
                client_id,
                ServerToClientMessage(
                    game_started=GameStartedMessage(
                        role=player.role,
                        end_time=self.game_ends_at,
                    )
                ),
            )

    async def _broadcast_lobby_update(self):
        for client_id in self.players.keys():
            await self._send_message(
                client_id,
                ServerToClientMessage(
                    lobby_updated=LobbyUpdatedMessage(
                        room_code=self.room_code,
                        player_names=[p.player_name for p in self.players.values()],
                        is_host=(client_id == self.host_client_id),
                    )
                ),
            )

    async def _send_message(self, client_id: UUID, message: ServerToClientMessage):
        player_info = self.players.get(client_id)
        if not player_info:
            raise ValueError("Client is not connected")
        if not player_info.websocket:
            # Player is disconnected - ignore
            return
        data = message.SerializeToString()
        await player_info.websocket.send_bytes(data)

    async def _broadcast_message(self, message: ServerToClientMessage):
        for client_id in self.players.keys():
            await self._send_message(client_id, message)

    async def _shutdown(self):
        # Close all connections
        for client_id, player in self.players.items():
            if player.websocket:
                await player.websocket.close()
            self.players.pop(client_id)

        # Release room code
        if self.room_code:
            self._room_code_store.release_code(self.room_code)
            self.room_code = None

        # Stop timers
        self._game_end_timer.cancel()

        # Remove self from rooms dict
        self._remove_self_from_rooms()

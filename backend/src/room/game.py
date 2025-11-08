import logging
from typing import Callable
from uuid import UUID

from fastapi import HTTPException, WebSocket

from protobuf.websocket_pb2 import ClientToServerMessage
from room.base import BaseRoom, PlayerInfo

logger = logging.getLogger(__name__)

class GameRoom(BaseRoom):
    def __init__(
        self,
        *,
        player_info: dict[UUID, PlayerInfo],
        on_finish_game: Callable[[UUID], None],
    ):
        super().__init__()
        self.player_info = player_info
        self._on_finish_game = on_finish_game

    async def connect(self, client_id: UUID, websocket: WebSocket):
        if client_id not in self.player_info:
            raise HTTPException(status_code=403, detail="Client not in player list")
        await super().connect(client_id, websocket)

    async def disconnect(self, client_id: UUID):
        await super().disconnect(client_id)

    async def process_message(self, client_id: UUID, message: ClientToServerMessage):
        pass

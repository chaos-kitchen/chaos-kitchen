import asyncio
import logging
from typing import Callable
from uuid import UUID

from fastapi import HTTPException, WebSocket

from protobuf.websocket_pb2 import (
    ClientToServerMessage,
    ServerToClientMessage,
    TimerUpdateMessage,
)
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
        
        # keep track of timer so we don’t start it twice
        self._timer_task: asyncio.Task | None = None

    async def connect(self, client_id: UUID, websocket: WebSocket):
        if client_id not in self.player_info:
            raise HTTPException(status_code=403, detail="Client not in player list")
        await super().connect(client_id, websocket)

    async def disconnect(self, client_id: UUID):
        await super().disconnect(client_id)

    async def process_message(self, client_id: UUID, message: ClientToServerMessage):
        pass

    # ------------------------------------------------------------------
    # SERVER TIMER (5 minutes) – uses SAME pattern as lobby: broadcast_message()
    # ------------------------------------------------------------------
    async def start_round_timer(self, total_seconds: int = 300):
        # if it's already running, do nothing
        if self._timer_task is not None:
            return

        async def _run():
            remaining = total_seconds
            while remaining >= 0:
                # if everyone left, stop
                if not self.active_connections:
                    break

                # build the protobuf the clients expect
                msg = ServerToClientMessage(
                    timer_update=TimerUpdateMessage(
                        remaining_seconds=remaining
                    )
                )

                # 👇 THIS is the important bit: same helper lobby uses
                await self.broadcast_message(msg)

                await asyncio.sleep(1)
                remaining -= 1

            self._timer_task = None

        self._timer_task = asyncio.create_task(_run())
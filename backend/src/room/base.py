from collections import OrderedDict
from dataclasses import dataclass
import logging
from uuid import UUID

from fastapi import WebSocket

from protobuf.websocket_pb2 import ClientToServerMessage, ServerToClientMessage

logger = logging.getLogger(__name__)

@dataclass
class PlayerInfo:
    player_name: str

class BaseRoom:
    def __init__(self):
        self.active_connections: OrderedDict[UUID, WebSocket] = OrderedDict()

    async def connect(self, client_id: UUID, websocket: WebSocket):
        if client_id in self.active_connections:
            await self.active_connections[client_id].close()
            logger.warning(f"Client {client_id} reconnected, closing previous connection")
            return
        await websocket.accept()
        self.active_connections[client_id] = websocket

    async def disconnect(self, client_id: UUID):
        self.active_connections.pop(client_id, None)

    async def receive_message(self, client_id: UUID, websocket: WebSocket):
        client_data = await websocket.receive_bytes()
        client_message = ClientToServerMessage()
        client_message.ParseFromString(client_data)
        await self.process_message(client_id, client_message)

    async def send_message(self, client_id: UUID, message: ServerToClientMessage):
        if client_id not in self.active_connections:
            raise ValueError("Client is not connected")
        data = message.SerializeToString()
        await self.active_connections[client_id].send_bytes(data)

    async def broadcast_message(self, message: ServerToClientMessage):
        data = message.SerializeToString()
        for websocket in self.active_connections.values():
            await websocket.send_bytes(data)

    # To be implemented by subclasses
    async def process_message(self, client_id: UUID, message: ClientToServerMessage):
        raise NotImplementedError()

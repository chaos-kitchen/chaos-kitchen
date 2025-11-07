import logging
from uuid import UUID

from fastapi import FastAPI, WebSocket, WebSocketDisconnect

from code_store import RoomCodeStore
from room.lobby import LobbyRoom
from room_manager import RoomManager

logger = logging.getLogger(__name__)

app = FastAPI()

code_store = RoomCodeStore()
rooms: dict[UUID, RoomManager] = {}

@app.get("/")
def root_route():
    return "Chaos Kitchen Backend"

@app.get("/room/code/{room_code}")
def get_room_id_by_code(room_code: str):
    for room_id, room_manager in rooms.items():
        if not isinstance(room_manager.room, LobbyRoom):
            continue
        if room_manager.room.room_code != room_code:
            continue
        return room_id
    return None

@app.websocket("/ws/{room_id}/{client_id}")
async def websocket_endpoint(websocket: WebSocket, room_id: UUID, client_id: UUID):
    room_manager = rooms.get(room_id)
    if room_manager is None:
        room_manager = RoomManager(room_id, code_store)
        rooms[room_id] = room_manager

    await room_manager.room.connect(client_id, websocket)
    try:
        while True:
            await room_manager.room.receive_message(client_id, websocket)
    except WebSocketDisconnect:
        await room_manager.room.disconnect(client_id)

    if room_manager.room.active_connections == 0:
        logger.info(f"No active connections left in room: {room_id}, deleting room manager")
        del rooms[room_id]


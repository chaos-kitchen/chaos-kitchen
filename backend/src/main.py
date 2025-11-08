import logging
from uuid import UUID

from fastapi import FastAPI, HTTPException, WebSocket, WebSocketDisconnect

from code_store import RoomCodeStore
from room_manager import RoomManager

logger = logging.getLogger(__name__)

app = FastAPI()

code_store = RoomCodeStore()
room_manager = RoomManager(code_store)

@app.get("/")
def root_route():
    return "Chaos Kitchen Backend"

@app.get("/room/code/{room_code}")
def get_room_id_by_code(room_code: str):
    for room_id, room in room_manager.lobby_rooms.items():
        if room.room_code == room_code:
            return room_id
    return None

@app.websocket("/ws/lobby/{room_id}/{client_id}")
async def lobby_websocket(websocket: WebSocket, room_id: UUID, client_id: UUID, player_name: str):
    room = room_manager.lobby_rooms.get(room_id) or room_manager.create_lobby_room(room_id)

    await room.connect(client_id, player_name, websocket)
    try:
        while True:
            await room.receive_message(client_id, websocket)
    except WebSocketDisconnect:
        await room.disconnect(client_id)

    if room.active_connections == 0:
        logger.info(f"No active connections left in lobby: {room_id}, deleting...")
        room_manager.lobby_rooms.pop(room_id, None)

@app.websocket("/ws/game/{room_id}/{client_id}")
async def game_websocket(websocket: WebSocket, room_id: UUID, client_id: UUID):
    room = room_manager.game_rooms.get(room_id)
    if room is None:
        raise HTTPException(status_code=404, detail="Game room not found")

    await room.connect(client_id, websocket)
    try:
        while True:
            await room.receive_message(client_id, websocket)
    except WebSocketDisconnect:
        await room.disconnect(client_id)

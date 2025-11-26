import logging
from uuid import UUID

from fastapi import FastAPI, WebSocket, WebSocketDisconnect

from code_store import RoomCodeStore
from room.game import GameRoom

logger = logging.getLogger(__name__)

app = FastAPI()

code_store = RoomCodeStore()
rooms: dict[UUID, GameRoom] = {}


@app.get("/")
def root_route():
    return "Chaos Kitchen Backend"


@app.get("/room/code/{room_code}")
def get_room_id_by_code(room_code: str):
    for room_id, room in rooms.items():
        if room.room_code == room_code:
            return room_id
    return None


@app.websocket("/ws/game/{room_id}/{client_id}")
async def game_websocket(
    websocket: WebSocket, room_id: UUID, client_id: UUID, player_name: str
):
    room = rooms.get(room_id)

    if room is None:
        room = GameRoom(
            room_code_store=code_store,
            remove_self_from_rooms=lambda: rooms.pop(room_id),
        )
        rooms[room_id] = room

    await room.connect(client_id, player_name, websocket)

    try:
        while True:
            await room.receive_message(client_id, websocket)
    except WebSocketDisconnect:
        await room.disconnect(client_id, websocket)

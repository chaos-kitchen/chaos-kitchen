from uuid import UUID

from code_store import RoomCodeStore
from room.base import BaseRoom
from room.lobby import LobbyRoom


class RoomManager:
    def __init__(self, room_id: UUID, code_store: RoomCodeStore):
        self.room: BaseRoom = LobbyRoom(room_id, code_store, replace_room=self.replace_room)

    def replace_room(self, new_room: BaseRoom):
        self.room = new_room

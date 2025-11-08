import logging
from uuid import UUID

from fastapi import FastAPI

from code_store import RoomCodeStore
from room.base import PlayerInfo
from room.game import GameRoom
from room.lobby import LobbyRoom

logger = logging.getLogger(__name__)

app = FastAPI()

class RoomManager:
    def __init__(self, code_store: RoomCodeStore):
        self.lobby_rooms: dict[UUID, LobbyRoom] = {}
        self.game_rooms: dict[UUID, GameRoom] = {}
        self._code_store = code_store

    def create_lobby_room(self, room_id: UUID) -> LobbyRoom:
        room = LobbyRoom(self._code_store, on_start_game=self._on_start_game)
        self.lobby_rooms[room_id] = room
        return room

    def _on_start_game(self, player_info: dict[UUID, PlayerInfo], new_room_id: UUID):
        new_game_room = GameRoom(player_info=player_info, on_finish_game=self._on_finish_game)
        self.game_rooms[new_room_id] = new_game_room

    def _on_finish_game(self, new_room_id: UUID):
        new_lobby_room = LobbyRoom(self._code_store, on_start_game=self._on_start_game)
        self.lobby_rooms[new_room_id] = new_lobby_room

from dataclasses import dataclass
from enum import Enum
from uuid import UUID

from code_store import RoomCodeStore

class LobbyRoom:
    def __init__(self, code_store: RoomCodeStore):
        self.code_store = code_store
        self.code = code_store.get_code()

    def __del__(self):
        self.code_store.free_code(self.code)


class RoomStatus(Enum):
    LOBBY = "waiting"
    STARTED = "in_progress"
    COMPLETED = "completed"

@dataclass
class PlayerInfo:
    id: UUID
    name: str


class RoomController:
    def __init__(self):
        self.players: dict[UUID, PlayerInfo] = {}
        self.status: RoomStatus = RoomStatus.LOBBY

    def add_player(self, player_info: PlayerInfo):
        self.players[player_info.id] = player_info

    def remove_player(self, player_id: UUID):
        self.players.pop(player_id, None)

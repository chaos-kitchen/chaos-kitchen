from google.protobuf.internal import containers as _containers
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from collections.abc import Iterable as _Iterable, Mapping as _Mapping
from typing import ClassVar as _ClassVar, Optional as _Optional, Union as _Union

DESCRIPTOR: _descriptor.FileDescriptor

class ClientToServerMessage(_message.Message):
    __slots__ = ()
    START_GAME_FIELD_NUMBER: _ClassVar[int]
    start_game: StartGameMessage
    def __init__(self, start_game: _Optional[_Union[StartGameMessage, _Mapping]] = ...) -> None: ...

class StartGameMessage(_message.Message):
    __slots__ = ()
    def __init__(self) -> None: ...

class ServerToClientMessage(_message.Message):
    __slots__ = ()
    LOBBY_UPDATED_FIELD_NUMBER: _ClassVar[int]
    GAME_STARTED_FIELD_NUMBER: _ClassVar[int]
    TIMER_UPDATE_FIELD_NUMBER: _ClassVar[int]
    lobby_updated: LobbyUpdatedMessage
    game_started: GameStartedMessage
    timer_update: TimerUpdateMessage
    def __init__(self, lobby_updated: _Optional[_Union[LobbyUpdatedMessage, _Mapping]] = ..., game_started: _Optional[_Union[GameStartedMessage, _Mapping]] = ..., timer_update: _Optional[_Union[TimerUpdateMessage, _Mapping]] = ...) -> None: ...

class LobbyUpdatedMessage(_message.Message):
    __slots__ = ()
    ROOM_CODE_FIELD_NUMBER: _ClassVar[int]
    PLAYER_NAMES_FIELD_NUMBER: _ClassVar[int]
    IS_HOST_FIELD_NUMBER: _ClassVar[int]
    room_code: str
    player_names: _containers.RepeatedScalarFieldContainer[str]
    is_host: bool
    def __init__(self, room_code: _Optional[str] = ..., player_names: _Optional[_Iterable[str]] = ..., is_host: _Optional[bool] = ...) -> None: ...

class GameStartedMessage(_message.Message):
    __slots__ = ()
    GAME_ROOM_ID_FIELD_NUMBER: _ClassVar[int]
    game_room_id: str
    def __init__(self, game_room_id: _Optional[str] = ...) -> None: ...

class TimerUpdateMessage(_message.Message):
    __slots__ = ()
    REMAINING_SECONDS_FIELD_NUMBER: _ClassVar[int]
    remaining_seconds: int
    def __init__(self, remaining_seconds: _Optional[int] = ...) -> None: ...

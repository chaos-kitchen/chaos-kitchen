import datetime

from google.protobuf import timestamp_pb2 as _timestamp_pb2
from google.protobuf.internal import containers as _containers
from google.protobuf.internal import enum_type_wrapper as _enum_type_wrapper
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from collections.abc import Iterable as _Iterable, Mapping as _Mapping
from typing import ClassVar as _ClassVar, Optional as _Optional, Union as _Union

DESCRIPTOR: _descriptor.FileDescriptor

class PlayerRole(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = ()
    PLAYER_ROLE_UNSPECIFIED: _ClassVar[PlayerRole]
    PLAYER_ROLE_COOK: _ClassVar[PlayerRole]
    PLAYER_ROLE_INSTRUCTOR: _ClassVar[PlayerRole]
PLAYER_ROLE_UNSPECIFIED: PlayerRole
PLAYER_ROLE_COOK: PlayerRole
PLAYER_ROLE_INSTRUCTOR: PlayerRole

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
    ROLE_FIELD_NUMBER: _ClassVar[int]
    END_TIME_FIELD_NUMBER: _ClassVar[int]
    role: PlayerRole
    end_time: _timestamp_pb2.Timestamp
    def __init__(self, role: _Optional[_Union[PlayerRole, str]] = ..., end_time: _Optional[_Union[datetime.datetime, _timestamp_pb2.Timestamp, _Mapping]] = ...) -> None: ...

class TimerUpdateMessage(_message.Message):
    __slots__ = ()
    REMAINING_SECONDS_FIELD_NUMBER: _ClassVar[int]
    remaining_seconds: int
    def __init__(self, remaining_seconds: _Optional[int] = ...) -> None: ...

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

class PbVector2(_message.Message):
    __slots__ = ()
    X_FIELD_NUMBER: _ClassVar[int]
    Y_FIELD_NUMBER: _ClassVar[int]
    x: float
    y: float
    def __init__(self, x: _Optional[float] = ..., y: _Optional[float] = ...) -> None: ...

class ClientToServerMessage(_message.Message):
    __slots__ = ()
    START_GAME_FIELD_NUMBER: _ClassVar[int]
    SWAP_ROLES_FIELD_NUMBER: _ClassVar[int]
    POSITION_UPDATE_FIELD_NUMBER: _ClassVar[int]
    INVENTORY_UPDATE_FIELD_NUMBER: _ClassVar[int]
    FURNACE_POWERED_FIELD_NUMBER: _ClassVar[int]
    start_game: StartGameMessage
    swap_roles: SwapRolesMessage
    position_update: PositionUpdateMessage
    inventory_update: InventoryUpdateMessage
    furnace_powered: FurnacePoweredMessage
    def __init__(self, start_game: _Optional[_Union[StartGameMessage, _Mapping]] = ..., swap_roles: _Optional[_Union[SwapRolesMessage, _Mapping]] = ..., position_update: _Optional[_Union[PositionUpdateMessage, _Mapping]] = ..., inventory_update: _Optional[_Union[InventoryUpdateMessage, _Mapping]] = ..., furnace_powered: _Optional[_Union[FurnacePoweredMessage, _Mapping]] = ...) -> None: ...

class StartGameMessage(_message.Message):
    __slots__ = ()
    def __init__(self) -> None: ...

class SwapRolesMessage(_message.Message):
    __slots__ = ()
    def __init__(self) -> None: ...

class PositionUpdateMessage(_message.Message):
    __slots__ = ()
    POSITION_FIELD_NUMBER: _ClassVar[int]
    position: PbVector2
    def __init__(self, position: _Optional[_Union[PbVector2, _Mapping]] = ...) -> None: ...

class InventoryUpdateMessage(_message.Message):
    __slots__ = ()
    ITEM_ID_FIELD_NUMBER: _ClassVar[int]
    item_id: str
    def __init__(self, item_id: _Optional[str] = ...) -> None: ...

class FurnacePoweredMessage(_message.Message):
    __slots__ = ()
    POWERED_AT_FIELD_NUMBER: _ClassVar[int]
    powered_at: _timestamp_pb2.Timestamp
    def __init__(self, powered_at: _Optional[_Union[datetime.datetime, _timestamp_pb2.Timestamp, _Mapping]] = ...) -> None: ...

class ServerToClientMessage(_message.Message):
    __slots__ = ()
    LOBBY_UPDATED_FIELD_NUMBER: _ClassVar[int]
    GAME_STARTED_FIELD_NUMBER: _ClassVar[int]
    OVEN_POWERED_FIELD_NUMBER: _ClassVar[int]
    lobby_updated: LobbyUpdatedMessage
    game_started: GameStartedMessage
    oven_powered: OvenPoweredMessage
    def __init__(self, lobby_updated: _Optional[_Union[LobbyUpdatedMessage, _Mapping]] = ..., game_started: _Optional[_Union[GameStartedMessage, _Mapping]] = ..., oven_powered: _Optional[_Union[OvenPoweredMessage, _Mapping]] = ...) -> None: ...

class LobbyUpdatedMessage(_message.Message):
    __slots__ = ()
    class PlayerRolesEntry(_message.Message):
        __slots__ = ()
        KEY_FIELD_NUMBER: _ClassVar[int]
        VALUE_FIELD_NUMBER: _ClassVar[int]
        key: str
        value: PlayerRole
        def __init__(self, key: _Optional[str] = ..., value: _Optional[_Union[PlayerRole, str]] = ...) -> None: ...
    ROOM_CODE_FIELD_NUMBER: _ClassVar[int]
    PLAYER_NAMES_FIELD_NUMBER: _ClassVar[int]
    IS_HOST_FIELD_NUMBER: _ClassVar[int]
    PLAYER_ROLES_FIELD_NUMBER: _ClassVar[int]
    room_code: str
    player_names: _containers.RepeatedScalarFieldContainer[str]
    is_host: bool
    player_roles: _containers.ScalarMap[str, PlayerRole]
    def __init__(self, room_code: _Optional[str] = ..., player_names: _Optional[_Iterable[str]] = ..., is_host: _Optional[bool] = ..., player_roles: _Optional[_Mapping[str, PlayerRole]] = ...) -> None: ...

class GameStartedMessage(_message.Message):
    __slots__ = ()
    ROLE_FIELD_NUMBER: _ClassVar[int]
    END_TIME_FIELD_NUMBER: _ClassVar[int]
    INITIAL_POSITION_FIELD_NUMBER: _ClassVar[int]
    HELD_ITEM_ID_FIELD_NUMBER: _ClassVar[int]
    OVEN_POWERED_FIELD_NUMBER: _ClassVar[int]
    role: PlayerRole
    end_time: _timestamp_pb2.Timestamp
    initial_position: PbVector2
    held_item_id: str
    oven_powered: OvenPoweredMessage
    def __init__(self, role: _Optional[_Union[PlayerRole, str]] = ..., end_time: _Optional[_Union[datetime.datetime, _timestamp_pb2.Timestamp, _Mapping]] = ..., initial_position: _Optional[_Union[PbVector2, _Mapping]] = ..., held_item_id: _Optional[str] = ..., oven_powered: _Optional[_Union[OvenPoweredMessage, _Mapping]] = ...) -> None: ...

class OvenPoweredMessage(_message.Message):
    __slots__ = ()
    TOTAL_DURATION_SECONDS_FIELD_NUMBER: _ClassVar[int]
    POWERED_UNTIL_FIELD_NUMBER: _ClassVar[int]
    total_duration_seconds: int
    powered_until: _timestamp_pb2.Timestamp
    def __init__(self, total_duration_seconds: _Optional[int] = ..., powered_until: _Optional[_Union[datetime.datetime, _timestamp_pb2.Timestamp, _Mapping]] = ...) -> None: ...

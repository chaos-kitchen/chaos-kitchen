from google.protobuf.internal import containers as _containers
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from collections.abc import Iterable as _Iterable, Mapping as _Mapping
from typing import ClassVar as _ClassVar, Optional as _Optional, Union as _Union

DESCRIPTOR: _descriptor.FileDescriptor

class ClientToServerMessage(_message.Message):
    __slots__ = ()
    PLAYER_UPDATED_FIELD_NUMBER: _ClassVar[int]
    player_updated: PlayerUpdatedMessage
    def __init__(self, player_updated: _Optional[_Union[PlayerUpdatedMessage, _Mapping]] = ...) -> None: ...

class PlayerUpdatedMessage(_message.Message):
    __slots__ = ()
    USERNAME_FIELD_NUMBER: _ClassVar[int]
    username: str
    def __init__(self, username: _Optional[str] = ...) -> None: ...

class ServerToClientMessage(_message.Message):
    __slots__ = ()
    LOBBY_UPDATED_FIELD_NUMBER: _ClassVar[int]
    lobby_updated: LobbyUpdatedMessage
    def __init__(self, lobby_updated: _Optional[_Union[LobbyUpdatedMessage, _Mapping]] = ...) -> None: ...

class LobbyUpdatedMessage(_message.Message):
    __slots__ = ()
    ROOM_CODE_FIELD_NUMBER: _ClassVar[int]
    USERNAMES_FIELD_NUMBER: _ClassVar[int]
    room_code: str
    usernames: _containers.RepeatedScalarFieldContainer[str]
    def __init__(self, room_code: _Optional[str] = ..., usernames: _Optional[_Iterable[str]] = ...) -> None: ...

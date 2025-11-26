// This is a generated file - do not edit.
//
// Generated from websocket.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $0;
import 'websocket.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'websocket.pbenum.dart';

class PbVector2 extends $pb.GeneratedMessage {
  factory PbVector2({
    $core.double? x,
    $core.double? y,
  }) {
    final result = create();
    if (x != null) result.x = x;
    if (y != null) result.y = y;
    return result;
  }

  PbVector2._();

  factory PbVector2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PbVector2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PbVector2',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'x')
    ..aD(2, _omitFieldNames ? '' : 'y')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PbVector2 clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PbVector2 copyWith(void Function(PbVector2) updates) =>
      super.copyWith((message) => updates(message as PbVector2)) as PbVector2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PbVector2 create() => PbVector2._();
  @$core.override
  PbVector2 createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PbVector2 getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PbVector2>(create);
  static PbVector2? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => $_clearField(2);
}

enum ClientToServerMessage_Payload {
  startGame,
  positionUpdate,
  inventoryUpdate,
  notSet
}

class ClientToServerMessage extends $pb.GeneratedMessage {
  factory ClientToServerMessage({
    StartGameMessage? startGame,
    PositionUpdateMessage? positionUpdate,
    InventoryUpdateMessage? inventoryUpdate,
  }) {
    final result = create();
    if (startGame != null) result.startGame = startGame;
    if (positionUpdate != null) result.positionUpdate = positionUpdate;
    if (inventoryUpdate != null) result.inventoryUpdate = inventoryUpdate;
    return result;
  }

  ClientToServerMessage._();

  factory ClientToServerMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ClientToServerMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ClientToServerMessage_Payload>
      _ClientToServerMessage_PayloadByTag = {
    1: ClientToServerMessage_Payload.startGame,
    2: ClientToServerMessage_Payload.positionUpdate,
    3: ClientToServerMessage_Payload.inventoryUpdate,
    0: ClientToServerMessage_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClientToServerMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<StartGameMessage>(1, _omitFieldNames ? '' : 'startGame',
        subBuilder: StartGameMessage.create)
    ..aOM<PositionUpdateMessage>(2, _omitFieldNames ? '' : 'positionUpdate',
        subBuilder: PositionUpdateMessage.create)
    ..aOM<InventoryUpdateMessage>(3, _omitFieldNames ? '' : 'inventoryUpdate',
        subBuilder: InventoryUpdateMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClientToServerMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClientToServerMessage copyWith(
          void Function(ClientToServerMessage) updates) =>
      super.copyWith((message) => updates(message as ClientToServerMessage))
          as ClientToServerMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClientToServerMessage create() => ClientToServerMessage._();
  @$core.override
  ClientToServerMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ClientToServerMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ClientToServerMessage>(create);
  static ClientToServerMessage? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  ClientToServerMessage_Payload whichPayload() =>
      _ClientToServerMessage_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  void clearPayload() => $_clearField($_whichOneof(0));

  /// Lobby messages
  @$pb.TagNumber(1)
  StartGameMessage get startGame => $_getN(0);
  @$pb.TagNumber(1)
  set startGame(StartGameMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartGame() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartGame() => $_clearField(1);
  @$pb.TagNumber(1)
  StartGameMessage ensureStartGame() => $_ensure(0);

  /// Game messages
  @$pb.TagNumber(2)
  PositionUpdateMessage get positionUpdate => $_getN(1);
  @$pb.TagNumber(2)
  set positionUpdate(PositionUpdateMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPositionUpdate() => $_has(1);
  @$pb.TagNumber(2)
  void clearPositionUpdate() => $_clearField(2);
  @$pb.TagNumber(2)
  PositionUpdateMessage ensurePositionUpdate() => $_ensure(1);

  @$pb.TagNumber(3)
  InventoryUpdateMessage get inventoryUpdate => $_getN(2);
  @$pb.TagNumber(3)
  set inventoryUpdate(InventoryUpdateMessage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasInventoryUpdate() => $_has(2);
  @$pb.TagNumber(3)
  void clearInventoryUpdate() => $_clearField(3);
  @$pb.TagNumber(3)
  InventoryUpdateMessage ensureInventoryUpdate() => $_ensure(2);
}

class StartGameMessage extends $pb.GeneratedMessage {
  factory StartGameMessage() => create();

  StartGameMessage._();

  factory StartGameMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StartGameMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StartGameMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StartGameMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StartGameMessage copyWith(void Function(StartGameMessage) updates) =>
      super.copyWith((message) => updates(message as StartGameMessage))
          as StartGameMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StartGameMessage create() => StartGameMessage._();
  @$core.override
  StartGameMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StartGameMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StartGameMessage>(create);
  static StartGameMessage? _defaultInstance;
}

class PositionUpdateMessage extends $pb.GeneratedMessage {
  factory PositionUpdateMessage({
    PbVector2? position,
  }) {
    final result = create();
    if (position != null) result.position = position;
    return result;
  }

  PositionUpdateMessage._();

  factory PositionUpdateMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PositionUpdateMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PositionUpdateMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..aOM<PbVector2>(1, _omitFieldNames ? '' : 'position',
        subBuilder: PbVector2.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PositionUpdateMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PositionUpdateMessage copyWith(
          void Function(PositionUpdateMessage) updates) =>
      super.copyWith((message) => updates(message as PositionUpdateMessage))
          as PositionUpdateMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PositionUpdateMessage create() => PositionUpdateMessage._();
  @$core.override
  PositionUpdateMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PositionUpdateMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PositionUpdateMessage>(create);
  static PositionUpdateMessage? _defaultInstance;

  @$pb.TagNumber(1)
  PbVector2 get position => $_getN(0);
  @$pb.TagNumber(1)
  set position(PbVector2 value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearPosition() => $_clearField(1);
  @$pb.TagNumber(1)
  PbVector2 ensurePosition() => $_ensure(0);
}

class InventoryUpdateMessage extends $pb.GeneratedMessage {
  factory InventoryUpdateMessage({
    $core.String? itemId,
  }) {
    final result = create();
    if (itemId != null) result.itemId = itemId;
    return result;
  }

  InventoryUpdateMessage._();

  factory InventoryUpdateMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InventoryUpdateMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InventoryUpdateMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'itemId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryUpdateMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryUpdateMessage copyWith(
          void Function(InventoryUpdateMessage) updates) =>
      super.copyWith((message) => updates(message as InventoryUpdateMessage))
          as InventoryUpdateMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InventoryUpdateMessage create() => InventoryUpdateMessage._();
  @$core.override
  InventoryUpdateMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InventoryUpdateMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InventoryUpdateMessage>(create);
  static InventoryUpdateMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => $_clearField(1);
}

enum ServerToClientMessage_Payload { lobbyUpdated, gameStarted, notSet }

class ServerToClientMessage extends $pb.GeneratedMessage {
  factory ServerToClientMessage({
    LobbyUpdatedMessage? lobbyUpdated,
    GameStartedMessage? gameStarted,
  }) {
    final result = create();
    if (lobbyUpdated != null) result.lobbyUpdated = lobbyUpdated;
    if (gameStarted != null) result.gameStarted = gameStarted;
    return result;
  }

  ServerToClientMessage._();

  factory ServerToClientMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServerToClientMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ServerToClientMessage_Payload>
      _ServerToClientMessage_PayloadByTag = {
    1: ServerToClientMessage_Payload.lobbyUpdated,
    2: ServerToClientMessage_Payload.gameStarted,
    0: ServerToClientMessage_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServerToClientMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<LobbyUpdatedMessage>(1, _omitFieldNames ? '' : 'lobbyUpdated',
        subBuilder: LobbyUpdatedMessage.create)
    ..aOM<GameStartedMessage>(2, _omitFieldNames ? '' : 'gameStarted',
        subBuilder: GameStartedMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServerToClientMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServerToClientMessage copyWith(
          void Function(ServerToClientMessage) updates) =>
      super.copyWith((message) => updates(message as ServerToClientMessage))
          as ServerToClientMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServerToClientMessage create() => ServerToClientMessage._();
  @$core.override
  ServerToClientMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ServerToClientMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServerToClientMessage>(create);
  static ServerToClientMessage? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  ServerToClientMessage_Payload whichPayload() =>
      _ServerToClientMessage_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearPayload() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  LobbyUpdatedMessage get lobbyUpdated => $_getN(0);
  @$pb.TagNumber(1)
  set lobbyUpdated(LobbyUpdatedMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLobbyUpdated() => $_has(0);
  @$pb.TagNumber(1)
  void clearLobbyUpdated() => $_clearField(1);
  @$pb.TagNumber(1)
  LobbyUpdatedMessage ensureLobbyUpdated() => $_ensure(0);

  @$pb.TagNumber(2)
  GameStartedMessage get gameStarted => $_getN(1);
  @$pb.TagNumber(2)
  set gameStarted(GameStartedMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasGameStarted() => $_has(1);
  @$pb.TagNumber(2)
  void clearGameStarted() => $_clearField(2);
  @$pb.TagNumber(2)
  GameStartedMessage ensureGameStarted() => $_ensure(1);
}

class LobbyUpdatedMessage extends $pb.GeneratedMessage {
  factory LobbyUpdatedMessage({
    $core.String? roomCode,
    $core.Iterable<$core.String>? playerNames,
    $core.bool? isHost,
  }) {
    final result = create();
    if (roomCode != null) result.roomCode = roomCode;
    if (playerNames != null) result.playerNames.addAll(playerNames);
    if (isHost != null) result.isHost = isHost;
    return result;
  }

  LobbyUpdatedMessage._();

  factory LobbyUpdatedMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LobbyUpdatedMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LobbyUpdatedMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomCode')
    ..pPS(2, _omitFieldNames ? '' : 'playerNames')
    ..aOB(3, _omitFieldNames ? '' : 'isHost')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LobbyUpdatedMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LobbyUpdatedMessage copyWith(void Function(LobbyUpdatedMessage) updates) =>
      super.copyWith((message) => updates(message as LobbyUpdatedMessage))
          as LobbyUpdatedMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LobbyUpdatedMessage create() => LobbyUpdatedMessage._();
  @$core.override
  LobbyUpdatedMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LobbyUpdatedMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LobbyUpdatedMessage>(create);
  static LobbyUpdatedMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get playerNames => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get isHost => $_getBF(2);
  @$pb.TagNumber(3)
  set isHost($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsHost() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsHost() => $_clearField(3);
}

class GameStartedMessage extends $pb.GeneratedMessage {
  factory GameStartedMessage({
    PlayerRole? role,
    $0.Timestamp? endTime,
    PbVector2? initialPosition,
    $core.String? heldItemId,
  }) {
    final result = create();
    if (role != null) result.role = role;
    if (endTime != null) result.endTime = endTime;
    if (initialPosition != null) result.initialPosition = initialPosition;
    if (heldItemId != null) result.heldItemId = heldItemId;
    return result;
  }

  GameStartedMessage._();

  factory GameStartedMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GameStartedMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GameStartedMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..aE<PlayerRole>(1, _omitFieldNames ? '' : 'role',
        enumValues: PlayerRole.values)
    ..aOM<$0.Timestamp>(2, _omitFieldNames ? '' : 'endTime',
        subBuilder: $0.Timestamp.create)
    ..aOM<PbVector2>(3, _omitFieldNames ? '' : 'initialPosition',
        subBuilder: PbVector2.create)
    ..aOS(4, _omitFieldNames ? '' : 'heldItemId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GameStartedMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GameStartedMessage copyWith(void Function(GameStartedMessage) updates) =>
      super.copyWith((message) => updates(message as GameStartedMessage))
          as GameStartedMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GameStartedMessage create() => GameStartedMessage._();
  @$core.override
  GameStartedMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GameStartedMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GameStartedMessage>(create);
  static GameStartedMessage? _defaultInstance;

  @$pb.TagNumber(1)
  PlayerRole get role => $_getN(0);
  @$pb.TagNumber(1)
  set role(PlayerRole value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRole() => $_has(0);
  @$pb.TagNumber(1)
  void clearRole() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Timestamp get endTime => $_getN(1);
  @$pb.TagNumber(2)
  set endTime($0.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndTime() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureEndTime() => $_ensure(1);

  @$pb.TagNumber(3)
  PbVector2 get initialPosition => $_getN(2);
  @$pb.TagNumber(3)
  set initialPosition(PbVector2 value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasInitialPosition() => $_has(2);
  @$pb.TagNumber(3)
  void clearInitialPosition() => $_clearField(3);
  @$pb.TagNumber(3)
  PbVector2 ensureInitialPosition() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get heldItemId => $_getSZ(3);
  @$pb.TagNumber(4)
  set heldItemId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHeldItemId() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeldItemId() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

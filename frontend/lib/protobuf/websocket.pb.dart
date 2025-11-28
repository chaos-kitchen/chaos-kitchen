// This is a generated file - do not edit.
//
// Generated from websocket.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

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
  furnacePowered,
  swapRoles,
  notSet
}

class ClientToServerMessage extends $pb.GeneratedMessage {
  factory ClientToServerMessage({
    StartGameMessage? startGame,
    PositionUpdateMessage? positionUpdate,
    InventoryUpdateMessage? inventoryUpdate,
    FurnacePoweredMessage? furnacePowered,
    SwapRolesMessage? swapRoles,
  }) {
    final result = create();
    if (startGame != null) result.startGame = startGame;
    if (positionUpdate != null) result.positionUpdate = positionUpdate;
    if (inventoryUpdate != null) result.inventoryUpdate = inventoryUpdate;
    if (furnacePowered != null) result.furnacePowered = furnacePowered;
    if (swapRoles != null) result.swapRoles = swapRoles;
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
    4: ClientToServerMessage_Payload.furnacePowered,
    5: ClientToServerMessage_Payload.swapRoles,
    0: ClientToServerMessage_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClientToServerMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5])
    ..aOM<StartGameMessage>(1, _omitFieldNames ? '' : 'startGame',
        subBuilder: StartGameMessage.create)
    ..aOM<PositionUpdateMessage>(2, _omitFieldNames ? '' : 'positionUpdate',
        subBuilder: PositionUpdateMessage.create)
    ..aOM<InventoryUpdateMessage>(3, _omitFieldNames ? '' : 'inventoryUpdate',
        subBuilder: InventoryUpdateMessage.create)
    ..aOM<FurnacePoweredMessage>(4, _omitFieldNames ? '' : 'furnacePowered',
        subBuilder: FurnacePoweredMessage.create)
    ..aOM<SwapRolesMessage>(5, _omitFieldNames ? '' : 'swapRoles',
        subBuilder: SwapRolesMessage.create)
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
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  ClientToServerMessage_Payload whichPayload() =>
      _ClientToServerMessage_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
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

  @$pb.TagNumber(4)
  FurnacePoweredMessage get furnacePowered => $_getN(3);
  @$pb.TagNumber(4)
  set furnacePowered(FurnacePoweredMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasFurnacePowered() => $_has(3);
  @$pb.TagNumber(4)
  void clearFurnacePowered() => $_clearField(4);
  @$pb.TagNumber(4)
  FurnacePoweredMessage ensureFurnacePowered() => $_ensure(3);

  @$pb.TagNumber(5)
  SwapRolesMessage get swapRoles => $_getN(4);
  @$pb.TagNumber(5)
  set swapRoles(SwapRolesMessage value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSwapRoles() => $_has(4);
  @$pb.TagNumber(5)
  void clearSwapRoles() => $_clearField(5);
  @$pb.TagNumber(5)
  SwapRolesMessage ensureSwapRoles() => $_ensure(4);
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

class SwapRolesMessage extends $pb.GeneratedMessage {
  factory SwapRolesMessage() => create();

  SwapRolesMessage._();

  factory SwapRolesMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SwapRolesMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SwapRolesMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SwapRolesMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SwapRolesMessage copyWith(void Function(SwapRolesMessage) updates) =>
      super.copyWith((message) => updates(message as SwapRolesMessage))
          as SwapRolesMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SwapRolesMessage create() => SwapRolesMessage._();
  @$core.override
  SwapRolesMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SwapRolesMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SwapRolesMessage>(create);
  static SwapRolesMessage? _defaultInstance;
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

class FurnacePoweredMessage extends $pb.GeneratedMessage {
  factory FurnacePoweredMessage({
    $0.Timestamp? poweredAt,
  }) {
    final result = create();
    if (poweredAt != null) result.poweredAt = poweredAt;
    return result;
  }

  FurnacePoweredMessage._();

  factory FurnacePoweredMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FurnacePoweredMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FurnacePoweredMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..aOM<$0.Timestamp>(1, _omitFieldNames ? '' : 'poweredAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FurnacePoweredMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FurnacePoweredMessage copyWith(
          void Function(FurnacePoweredMessage) updates) =>
      super.copyWith((message) => updates(message as FurnacePoweredMessage))
          as FurnacePoweredMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FurnacePoweredMessage create() => FurnacePoweredMessage._();
  @$core.override
  FurnacePoweredMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FurnacePoweredMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FurnacePoweredMessage>(create);
  static FurnacePoweredMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Timestamp get poweredAt => $_getN(0);
  @$pb.TagNumber(1)
  set poweredAt($0.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPoweredAt() => $_has(0);
  @$pb.TagNumber(1)
  void clearPoweredAt() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Timestamp ensurePoweredAt() => $_ensure(0);
}

enum ServerToClientMessage_Payload {
  lobbyUpdated,
  gameStarted,
  ovenPowered,
  notSet
}

class ServerToClientMessage extends $pb.GeneratedMessage {
  factory ServerToClientMessage({
    LobbyUpdatedMessage? lobbyUpdated,
    GameStartedMessage? gameStarted,
    OvenPoweredMessage? ovenPowered,
  }) {
    final result = create();
    if (lobbyUpdated != null) result.lobbyUpdated = lobbyUpdated;
    if (gameStarted != null) result.gameStarted = gameStarted;
    if (ovenPowered != null) result.ovenPowered = ovenPowered;
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
    3: ServerToClientMessage_Payload.ovenPowered,
    0: ServerToClientMessage_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServerToClientMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<LobbyUpdatedMessage>(1, _omitFieldNames ? '' : 'lobbyUpdated',
        subBuilder: LobbyUpdatedMessage.create)
    ..aOM<GameStartedMessage>(2, _omitFieldNames ? '' : 'gameStarted',
        subBuilder: GameStartedMessage.create)
    ..aOM<OvenPoweredMessage>(3, _omitFieldNames ? '' : 'ovenPowered',
        subBuilder: OvenPoweredMessage.create)
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
  @$pb.TagNumber(3)
  ServerToClientMessage_Payload whichPayload() =>
      _ServerToClientMessage_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
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

  @$pb.TagNumber(3)
  OvenPoweredMessage get ovenPowered => $_getN(2);
  @$pb.TagNumber(3)
  set ovenPowered(OvenPoweredMessage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasOvenPowered() => $_has(2);
  @$pb.TagNumber(3)
  void clearOvenPowered() => $_clearField(3);
  @$pb.TagNumber(3)
  OvenPoweredMessage ensureOvenPowered() => $_ensure(2);
}

class LobbyUpdatedMessage extends $pb.GeneratedMessage {
  factory LobbyUpdatedMessage({
    $core.String? roomCode,
    $core.Iterable<$core.String>? playerNames,
    $core.bool? isHost,
    $core.Iterable<$core.MapEntry<$core.String, PlayerRole>>? playerRoles,
  }) {
    final result = create();
    if (roomCode != null) result.roomCode = roomCode;
    if (playerNames != null) result.playerNames.addAll(playerNames);
    if (isHost != null) result.isHost = isHost;
    if (playerRoles != null) result.playerRoles.addEntries(playerRoles);
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
    ..m<$core.String, PlayerRole>(4, _omitFieldNames ? '' : 'playerRoles',
        entryClassName: 'LobbyUpdatedMessage.PlayerRolesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: PlayerRole.valueOf,
        enumValues: PlayerRole.values,
        valueDefaultOrMaker: PlayerRole.PLAYER_ROLE_UNSPECIFIED,
        defaultEnumValue: PlayerRole.PLAYER_ROLE_UNSPECIFIED,
        packageName: const $pb.PackageName('websocket'))
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

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, PlayerRole> get playerRoles => $_getMap(3);
}

class GameStartedMessage extends $pb.GeneratedMessage {
  factory GameStartedMessage({
    PlayerRole? role,
    $0.Timestamp? endTime,
    PbVector2? initialPosition,
    $core.String? heldItemId,
    OvenPoweredMessage? ovenPowered,
  }) {
    final result = create();
    if (role != null) result.role = role;
    if (endTime != null) result.endTime = endTime;
    if (initialPosition != null) result.initialPosition = initialPosition;
    if (heldItemId != null) result.heldItemId = heldItemId;
    if (ovenPowered != null) result.ovenPowered = ovenPowered;
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
    ..aOM<OvenPoweredMessage>(5, _omitFieldNames ? '' : 'ovenPowered',
        subBuilder: OvenPoweredMessage.create)
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

  @$pb.TagNumber(5)
  OvenPoweredMessage get ovenPowered => $_getN(4);
  @$pb.TagNumber(5)
  set ovenPowered(OvenPoweredMessage value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasOvenPowered() => $_has(4);
  @$pb.TagNumber(5)
  void clearOvenPowered() => $_clearField(5);
  @$pb.TagNumber(5)
  OvenPoweredMessage ensureOvenPowered() => $_ensure(4);
}

class OvenPoweredMessage extends $pb.GeneratedMessage {
  factory OvenPoweredMessage({
    $core.int? totalDurationSeconds,
    $0.Timestamp? poweredUntil,
  }) {
    final result = create();
    if (totalDurationSeconds != null)
      result.totalDurationSeconds = totalDurationSeconds;
    if (poweredUntil != null) result.poweredUntil = poweredUntil;
    return result;
  }

  OvenPoweredMessage._();

  factory OvenPoweredMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OvenPoweredMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OvenPoweredMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'totalDurationSeconds')
    ..aOM<$0.Timestamp>(2, _omitFieldNames ? '' : 'poweredUntil',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OvenPoweredMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OvenPoweredMessage copyWith(void Function(OvenPoweredMessage) updates) =>
      super.copyWith((message) => updates(message as OvenPoweredMessage))
          as OvenPoweredMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OvenPoweredMessage create() => OvenPoweredMessage._();
  @$core.override
  OvenPoweredMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OvenPoweredMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OvenPoweredMessage>(create);
  static OvenPoweredMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalDurationSeconds => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalDurationSeconds($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalDurationSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalDurationSeconds() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Timestamp get poweredUntil => $_getN(1);
  @$pb.TagNumber(2)
  set poweredUntil($0.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPoweredUntil() => $_has(1);
  @$pb.TagNumber(2)
  void clearPoweredUntil() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensurePoweredUntil() => $_ensure(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

enum ClientToServerMessage_Payload { startGame, notSet }

class ClientToServerMessage extends $pb.GeneratedMessage {
  factory ClientToServerMessage({
    StartGameMessage? startGame,
  }) {
    final result = create();
    if (startGame != null) result.startGame = startGame;
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
    0: ClientToServerMessage_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClientToServerMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..oo(0, [1])
    ..aOM<StartGameMessage>(1, _omitFieldNames ? '' : 'startGame',
        subBuilder: StartGameMessage.create)
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
  ClientToServerMessage_Payload whichPayload() =>
      _ClientToServerMessage_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField($_whichOneof(0));

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
    $core.String? gameRoomId,
  }) {
    final result = create();
    if (gameRoomId != null) result.gameRoomId = gameRoomId;
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
    ..aOS(1, _omitFieldNames ? '' : 'gameRoomId')
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
  $core.String get gameRoomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set gameRoomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGameRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameRoomId() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

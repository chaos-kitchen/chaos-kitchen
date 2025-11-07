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

enum ClientToServerMessage_Payload { playerUpdated, notSet }

class ClientToServerMessage extends $pb.GeneratedMessage {
  factory ClientToServerMessage({
    PlayerUpdatedMessage? playerUpdated,
  }) {
    final result = create();
    if (playerUpdated != null) result.playerUpdated = playerUpdated;
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
    1: ClientToServerMessage_Payload.playerUpdated,
    0: ClientToServerMessage_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClientToServerMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..oo(0, [1])
    ..aOM<PlayerUpdatedMessage>(1, _omitFieldNames ? '' : 'playerUpdated',
        subBuilder: PlayerUpdatedMessage.create)
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
  PlayerUpdatedMessage get playerUpdated => $_getN(0);
  @$pb.TagNumber(1)
  set playerUpdated(PlayerUpdatedMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPlayerUpdated() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayerUpdated() => $_clearField(1);
  @$pb.TagNumber(1)
  PlayerUpdatedMessage ensurePlayerUpdated() => $_ensure(0);
}

class PlayerUpdatedMessage extends $pb.GeneratedMessage {
  factory PlayerUpdatedMessage({
    $core.String? username,
  }) {
    final result = create();
    if (username != null) result.username = username;
    return result;
  }

  PlayerUpdatedMessage._();

  factory PlayerUpdatedMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PlayerUpdatedMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlayerUpdatedMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayerUpdatedMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayerUpdatedMessage copyWith(void Function(PlayerUpdatedMessage) updates) =>
      super.copyWith((message) => updates(message as PlayerUpdatedMessage))
          as PlayerUpdatedMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerUpdatedMessage create() => PlayerUpdatedMessage._();
  @$core.override
  PlayerUpdatedMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PlayerUpdatedMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlayerUpdatedMessage>(create);
  static PlayerUpdatedMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);
}

enum ServerToClientMessage_Payload { lobbyUpdated, notSet }

class ServerToClientMessage extends $pb.GeneratedMessage {
  factory ServerToClientMessage({
    LobbyUpdatedMessage? lobbyUpdated,
  }) {
    final result = create();
    if (lobbyUpdated != null) result.lobbyUpdated = lobbyUpdated;
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
    0: ServerToClientMessage_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServerToClientMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'websocket'),
      createEmptyInstance: create)
    ..oo(0, [1])
    ..aOM<LobbyUpdatedMessage>(1, _omitFieldNames ? '' : 'lobbyUpdated',
        subBuilder: LobbyUpdatedMessage.create)
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
  ServerToClientMessage_Payload whichPayload() =>
      _ServerToClientMessage_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
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
}

class LobbyUpdatedMessage extends $pb.GeneratedMessage {
  factory LobbyUpdatedMessage({
    $core.String? roomCode,
    $core.Iterable<$core.String>? usernames,
  }) {
    final result = create();
    if (roomCode != null) result.roomCode = roomCode;
    if (usernames != null) result.usernames.addAll(usernames);
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
    ..pPS(2, _omitFieldNames ? '' : 'usernames')
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
  $pb.PbList<$core.String> get usernames => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

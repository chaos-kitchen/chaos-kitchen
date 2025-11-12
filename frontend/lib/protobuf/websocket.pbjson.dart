// This is a generated file - do not edit.
//
// Generated from websocket.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use clientToServerMessageDescriptor instead')
const ClientToServerMessage$json = {
  '1': 'ClientToServerMessage',
  '2': [
    {
      '1': 'start_game',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.websocket.StartGameMessage',
      '9': 0,
      '10': 'startGame'
    },
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `ClientToServerMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientToServerMessageDescriptor = $convert.base64Decode(
    'ChVDbGllbnRUb1NlcnZlck1lc3NhZ2USPAoKc3RhcnRfZ2FtZRgBIAEoCzIbLndlYnNvY2tldC'
    '5TdGFydEdhbWVNZXNzYWdlSABSCXN0YXJ0R2FtZUIJCgdwYXlsb2Fk');

@$core.Deprecated('Use startGameMessageDescriptor instead')
const StartGameMessage$json = {
  '1': 'StartGameMessage',
};

/// Descriptor for `StartGameMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startGameMessageDescriptor =
    $convert.base64Decode('ChBTdGFydEdhbWVNZXNzYWdl');

@$core.Deprecated('Use serverToClientMessageDescriptor instead')
const ServerToClientMessage$json = {
  '1': 'ServerToClientMessage',
  '2': [
    {
      '1': 'lobby_updated',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.websocket.LobbyUpdatedMessage',
      '9': 0,
      '10': 'lobbyUpdated'
    },
    {
      '1': 'game_started',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.websocket.GameStartedMessage',
      '9': 0,
      '10': 'gameStarted'
    },
    {
      '1': 'timer_update',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.websocket.TimerUpdateMessage',
      '9': 0,
      '10': 'timerUpdate'
    },
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `ServerToClientMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverToClientMessageDescriptor = $convert.base64Decode(
    'ChVTZXJ2ZXJUb0NsaWVudE1lc3NhZ2USRQoNbG9iYnlfdXBkYXRlZBgBIAEoCzIeLndlYnNvY2'
    'tldC5Mb2JieVVwZGF0ZWRNZXNzYWdlSABSDGxvYmJ5VXBkYXRlZBJCCgxnYW1lX3N0YXJ0ZWQY'
    'AiABKAsyHS53ZWJzb2NrZXQuR2FtZVN0YXJ0ZWRNZXNzYWdlSABSC2dhbWVTdGFydGVkEkIKDH'
    'RpbWVyX3VwZGF0ZRgDIAEoCzIdLndlYnNvY2tldC5UaW1lclVwZGF0ZU1lc3NhZ2VIAFILdGlt'
    'ZXJVcGRhdGVCCQoHcGF5bG9hZA==');

@$core.Deprecated('Use lobbyUpdatedMessageDescriptor instead')
const LobbyUpdatedMessage$json = {
  '1': 'LobbyUpdatedMessage',
  '2': [
    {'1': 'room_code', '3': 1, '4': 1, '5': 9, '10': 'roomCode'},
    {'1': 'player_names', '3': 2, '4': 3, '5': 9, '10': 'playerNames'},
    {'1': 'is_host', '3': 3, '4': 1, '5': 8, '10': 'isHost'},
  ],
};

/// Descriptor for `LobbyUpdatedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lobbyUpdatedMessageDescriptor = $convert.base64Decode(
    'ChNMb2JieVVwZGF0ZWRNZXNzYWdlEhsKCXJvb21fY29kZRgBIAEoCVIIcm9vbUNvZGUSIQoMcG'
    'xheWVyX25hbWVzGAIgAygJUgtwbGF5ZXJOYW1lcxIXCgdpc19ob3N0GAMgASgIUgZpc0hvc3Q=');

@$core.Deprecated('Use gameStartedMessageDescriptor instead')
const GameStartedMessage$json = {
  '1': 'GameStartedMessage',
  '2': [
    {'1': 'game_room_id', '3': 1, '4': 1, '5': 9, '10': 'gameRoomId'},
  ],
};

/// Descriptor for `GameStartedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameStartedMessageDescriptor = $convert.base64Decode(
    'ChJHYW1lU3RhcnRlZE1lc3NhZ2USIAoMZ2FtZV9yb29tX2lkGAEgASgJUgpnYW1lUm9vbUlk');

@$core.Deprecated('Use timerUpdateMessageDescriptor instead')
const TimerUpdateMessage$json = {
  '1': 'TimerUpdateMessage',
  '2': [
    {
      '1': 'remaining_seconds',
      '3': 1,
      '4': 1,
      '5': 5,
      '10': 'remainingSeconds'
    },
  ],
};

/// Descriptor for `TimerUpdateMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timerUpdateMessageDescriptor = $convert.base64Decode(
    'ChJUaW1lclVwZGF0ZU1lc3NhZ2USKwoRcmVtYWluaW5nX3NlY29uZHMYASABKAVSEHJlbWFpbm'
    'luZ1NlY29uZHM=');

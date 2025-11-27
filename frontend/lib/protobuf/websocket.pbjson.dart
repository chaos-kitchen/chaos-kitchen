// This is a generated file - do not edit.
//
// Generated from websocket.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use playerRoleDescriptor instead')
const PlayerRole$json = {
  '1': 'PlayerRole',
  '2': [
    {'1': 'PLAYER_ROLE_UNSPECIFIED', '2': 0},
    {'1': 'PLAYER_ROLE_COOK', '2': 1},
    {'1': 'PLAYER_ROLE_INSTRUCTOR', '2': 2},
  ],
};

/// Descriptor for `PlayerRole`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List playerRoleDescriptor = $convert.base64Decode(
    'CgpQbGF5ZXJSb2xlEhsKF1BMQVlFUl9ST0xFX1VOU1BFQ0lGSUVEEAASFAoQUExBWUVSX1JPTE'
    'VfQ09PSxABEhoKFlBMQVlFUl9ST0xFX0lOU1RSVUNUT1IQAg==');

@$core.Deprecated('Use pbVector2Descriptor instead')
const PbVector2$json = {
  '1': 'PbVector2',
  '2': [
    {'1': 'x', '3': 1, '4': 1, '5': 1, '10': 'x'},
    {'1': 'y', '3': 2, '4': 1, '5': 1, '10': 'y'},
  ],
};

/// Descriptor for `PbVector2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pbVector2Descriptor = $convert
    .base64Decode('CglQYlZlY3RvcjISDAoBeBgBIAEoAVIBeBIMCgF5GAIgASgBUgF5');

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
    {
      '1': 'position_update',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.websocket.PositionUpdateMessage',
      '9': 0,
      '10': 'positionUpdate'
    },
    {
      '1': 'inventory_update',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.websocket.InventoryUpdateMessage',
      '9': 0,
      '10': 'inventoryUpdate'
    },
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `ClientToServerMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientToServerMessageDescriptor = $convert.base64Decode(
    'ChVDbGllbnRUb1NlcnZlck1lc3NhZ2USPAoKc3RhcnRfZ2FtZRgBIAEoCzIbLndlYnNvY2tldC'
    '5TdGFydEdhbWVNZXNzYWdlSABSCXN0YXJ0R2FtZRJLCg9wb3NpdGlvbl91cGRhdGUYAiABKAsy'
    'IC53ZWJzb2NrZXQuUG9zaXRpb25VcGRhdGVNZXNzYWdlSABSDnBvc2l0aW9uVXBkYXRlEk4KEG'
    'ludmVudG9yeV91cGRhdGUYAyABKAsyIS53ZWJzb2NrZXQuSW52ZW50b3J5VXBkYXRlTWVzc2Fn'
    'ZUgAUg9pbnZlbnRvcnlVcGRhdGVCCQoHcGF5bG9hZA==');

@$core.Deprecated('Use startGameMessageDescriptor instead')
const StartGameMessage$json = {
  '1': 'StartGameMessage',
};

/// Descriptor for `StartGameMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List startGameMessageDescriptor =
    $convert.base64Decode('ChBTdGFydEdhbWVNZXNzYWdl');

@$core.Deprecated('Use positionUpdateMessageDescriptor instead')
const PositionUpdateMessage$json = {
  '1': 'PositionUpdateMessage',
  '2': [
    {
      '1': 'position',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.websocket.PbVector2',
      '10': 'position'
    },
  ],
};

/// Descriptor for `PositionUpdateMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List positionUpdateMessageDescriptor = $convert.base64Decode(
    'ChVQb3NpdGlvblVwZGF0ZU1lc3NhZ2USMAoIcG9zaXRpb24YASABKAsyFC53ZWJzb2NrZXQuUG'
    'JWZWN0b3IyUghwb3NpdGlvbg==');

@$core.Deprecated('Use inventoryUpdateMessageDescriptor instead')
const InventoryUpdateMessage$json = {
  '1': 'InventoryUpdateMessage',
  '2': [
    {'1': 'item_id', '3': 1, '4': 1, '5': 9, '10': 'itemId'},
  ],
};

/// Descriptor for `InventoryUpdateMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inventoryUpdateMessageDescriptor =
    $convert.base64Decode(
        'ChZJbnZlbnRvcnlVcGRhdGVNZXNzYWdlEhcKB2l0ZW1faWQYASABKAlSBml0ZW1JZA==');

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
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `ServerToClientMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverToClientMessageDescriptor = $convert.base64Decode(
    'ChVTZXJ2ZXJUb0NsaWVudE1lc3NhZ2USRQoNbG9iYnlfdXBkYXRlZBgBIAEoCzIeLndlYnNvY2'
    'tldC5Mb2JieVVwZGF0ZWRNZXNzYWdlSABSDGxvYmJ5VXBkYXRlZBJCCgxnYW1lX3N0YXJ0ZWQY'
    'AiABKAsyHS53ZWJzb2NrZXQuR2FtZVN0YXJ0ZWRNZXNzYWdlSABSC2dhbWVTdGFydGVkQgkKB3'
    'BheWxvYWQ=');

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
    {
      '1': 'role',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.websocket.PlayerRole',
      '10': 'role'
    },
    {
      '1': 'end_time',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'endTime'
    },
    {
      '1': 'initial_position',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.websocket.PbVector2',
      '10': 'initialPosition'
    },
    {'1': 'held_item_id', '3': 4, '4': 1, '5': 9, '10': 'heldItemId'},
  ],
};

/// Descriptor for `GameStartedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameStartedMessageDescriptor = $convert.base64Decode(
    'ChJHYW1lU3RhcnRlZE1lc3NhZ2USKQoEcm9sZRgBIAEoDjIVLndlYnNvY2tldC5QbGF5ZXJSb2'
    'xlUgRyb2xlEjUKCGVuZF90aW1lGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIH'
    'ZW5kVGltZRI/ChBpbml0aWFsX3Bvc2l0aW9uGAMgASgLMhQud2Vic29ja2V0LlBiVmVjdG9yMl'
    'IPaW5pdGlhbFBvc2l0aW9uEiAKDGhlbGRfaXRlbV9pZBgEIAEoCVIKaGVsZEl0ZW1JZA==');

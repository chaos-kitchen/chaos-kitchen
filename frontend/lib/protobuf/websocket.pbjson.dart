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
      '1': 'player_updated',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.websocket.PlayerUpdatedMessage',
      '9': 0,
      '10': 'playerUpdated'
    },
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `ClientToServerMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientToServerMessageDescriptor = $convert.base64Decode(
    'ChVDbGllbnRUb1NlcnZlck1lc3NhZ2USSAoOcGxheWVyX3VwZGF0ZWQYASABKAsyHy53ZWJzb2'
    'NrZXQuUGxheWVyVXBkYXRlZE1lc3NhZ2VIAFINcGxheWVyVXBkYXRlZEIJCgdwYXlsb2Fk');

@$core.Deprecated('Use playerUpdatedMessageDescriptor instead')
const PlayerUpdatedMessage$json = {
  '1': 'PlayerUpdatedMessage',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `PlayerUpdatedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerUpdatedMessageDescriptor =
    $convert.base64Decode(
        'ChRQbGF5ZXJVcGRhdGVkTWVzc2FnZRIaCgh1c2VybmFtZRgBIAEoCVIIdXNlcm5hbWU=');

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
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `ServerToClientMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverToClientMessageDescriptor = $convert.base64Decode(
    'ChVTZXJ2ZXJUb0NsaWVudE1lc3NhZ2USRQoNbG9iYnlfdXBkYXRlZBgBIAEoCzIeLndlYnNvY2'
    'tldC5Mb2JieVVwZGF0ZWRNZXNzYWdlSABSDGxvYmJ5VXBkYXRlZEIJCgdwYXlsb2Fk');

@$core.Deprecated('Use lobbyUpdatedMessageDescriptor instead')
const LobbyUpdatedMessage$json = {
  '1': 'LobbyUpdatedMessage',
  '2': [
    {'1': 'room_code', '3': 1, '4': 1, '5': 9, '10': 'roomCode'},
    {'1': 'usernames', '3': 2, '4': 3, '5': 9, '10': 'usernames'},
  ],
};

/// Descriptor for `LobbyUpdatedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lobbyUpdatedMessageDescriptor = $convert.base64Decode(
    'ChNMb2JieVVwZGF0ZWRNZXNzYWdlEhsKCXJvb21fY29kZRgBIAEoCVIIcm9vbUNvZGUSHAoJdX'
    'Nlcm5hbWVzGAIgAygJUgl1c2VybmFtZXM=');

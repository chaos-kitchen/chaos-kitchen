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

class PlayerRole extends $pb.ProtobufEnum {
  static const PlayerRole PLAYER_ROLE_UNSPECIFIED =
      PlayerRole._(0, _omitEnumNames ? '' : 'PLAYER_ROLE_UNSPECIFIED');
  static const PlayerRole PLAYER_ROLE_COOK =
      PlayerRole._(1, _omitEnumNames ? '' : 'PLAYER_ROLE_COOK');
  static const PlayerRole PLAYER_ROLE_INSTRUCTOR =
      PlayerRole._(2, _omitEnumNames ? '' : 'PLAYER_ROLE_INSTRUCTOR');

  static const $core.List<PlayerRole> values = <PlayerRole>[
    PLAYER_ROLE_UNSPECIFIED,
    PLAYER_ROLE_COOK,
    PLAYER_ROLE_INSTRUCTOR,
  ];

  static final $core.List<PlayerRole?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static PlayerRole? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PlayerRole._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');

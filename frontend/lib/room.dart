import 'package:chaos_kitchen/change_name.dart';
import 'package:chaos_kitchen/room/game.dart';
import 'package:chaos_kitchen/room/lobby.dart';
import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  final String initialRoomId;

  const RoomScreen({super.key, required this.initialRoomId});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  String? _playerName;
  String? _roomId;
  bool _gameStarted = false;

  @override
  void initState() {
    super.initState();
  }

  void onNameChanged(String playerName) async {
    setState(() {
      _playerName = playerName;
    });
  }

  void onGameStarted(String gameRoomId) {
    setState(() {
      _gameStarted = true;
      _roomId = gameRoomId;
    });
  }

  void onGameFinished(String lobbyRoomId) {
    setState(() {
      _gameStarted = false;
      _roomId = lobbyRoomId;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_playerName == null) {
      return ChangePlayerNameScreen(onNameChanged: onNameChanged);
    }

    if (!_gameStarted) {
      return LobbyRoomScreen(
        roomId: _roomId ?? widget.initialRoomId,
        playerName: _playerName!,
        onGameStarted: onGameStarted,
      );
    }

    return GameScreen(
      roomId: _roomId ?? widget.initialRoomId,
      playerName: _playerName!,
      onGameFinished: onGameFinished,
    );
  }
}

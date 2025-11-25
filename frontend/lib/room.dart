import 'package:chaos_kitchen/room/game.dart';
import 'package:chaos_kitchen/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoomScreen extends StatefulWidget {
  final GoRouter router;
  final String roomId;

  const RoomScreen({super.key, required this.roomId, required this.router});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  String _playerName = '';

  Future<void> loadPlayerName() async {
    final currentName = await getPlayerNameFromPrefs();
    if (!mounted) return;

    if (currentName.isEmpty) {
      widget.router.go('/change-name?roomId=${widget.roomId}');
      return;
    }

    setState(() {
      _playerName = currentName;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPlayerName();
  }

  @override
  Widget build(BuildContext context) {
    if (_playerName.isEmpty) {
      return CircularProgressIndicator();
    }

    return GameScreen(roomId: widget.roomId, playerName: _playerName);
  }
}

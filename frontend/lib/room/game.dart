import 'package:chaos_kitchen/components/snackbar.dart';
import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:chaos_kitchen/utils/config.dart';
import 'package:chaos_kitchen/utils/prefs.dart';
import 'package:chaos_kitchen/utils/websocket_controller.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String roomId;
  final String playerName;
  final void Function(String lobbyRoomId) onGameFinished;

  const GameScreen({
    super.key,
    required this.roomId,
    required this.playerName,
    required this.onGameFinished,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late WebSocketController _wsController;

  bool isLoadingRoom = true;

  Future<void> createWebSocketConnection() async {
    final clientId = await getClientIdFromPrefs();
    if (!mounted) return;

    final wsUrl = AppConfig.getGameWebSocketUri(
      gameRoomId: widget.roomId,
      clientId: clientId,
      playerName: widget.playerName,
    );
    final controller = WebSocketController(wsUrl);
    await controller.initialize();
    if (!mounted) return;

    _wsController = controller;
    controller.stream.listen(handleMessage);
  }

  @override
  void initState() {
    super.initState();

    createWebSocketConnection();
  }

  @override
  void dispose() {
    super.dispose();
    _wsController.dispose();
  }

  void handleMessage(ServerToClientMessage message) {
    switch (message.whichPayload()) {
      default:
        showErrorSnackbar(context, 'Received unknown message from server');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: FlameGame());
  }
}

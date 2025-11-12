import 'package:chaos_kitchen/components/instructor_timer.dart';
import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:chaos_kitchen/utils/config.dart';
import 'package:chaos_kitchen/utils/prefs.dart';
import 'package:chaos_kitchen/utils/websocket_controller.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String roomId;
  final String playerName;

  final bool isHost;

  final void Function(String lobbyRoomId) onGameFinished;

  const GameScreen({
    super.key,
    required this.roomId,
    required this.playerName,
    required this.isHost,
    required this.onGameFinished,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late WebSocketController _wsController;

  // 1) keep game instance stable so it doesn't rebuild
  final ChaosKitchenGame _game = ChaosKitchenGame();

  // 2) use a notifier for the timer
  final ValueNotifier<int?> _remainingSeconds = ValueNotifier<int?>(null);

  @override
  void initState() {
    super.initState();
    _createWs();
  }

  Future<void> _createWs() async {
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
    _wsController.stream.listen(_handleMessage);
  }

  @override
  void dispose() {
    _remainingSeconds.dispose();
    _wsController.dispose();
    super.dispose();
  }

  void _handleMessage(ServerToClientMessage message) {
    switch (message.whichPayload()) {
      case ServerToClientMessage_Payload.timerUpdate:
        // 3) update the notifier, NOT setState
        _remainingSeconds.value = message.timerUpdate.remainingSeconds;
        break;

      default:
        // optional
        // showErrorSnackbar(context, 'Received unknown message from server');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 4) game stays stable
        GameWidget(game: _game),

        // 5) only this part rebuilds every second
        if (widget.isHost)
          Positioned(
            top: 16,
            right: 16,
            child: ValueListenableBuilder<int?>(
              valueListenable: _remainingSeconds,
              builder: (context, secs, _) {
                if (secs == null) return const SizedBox.shrink();
                return InstructorTimer(remainingSeconds: secs);
              },
            ),
          ),
      ],
    );
  }
}

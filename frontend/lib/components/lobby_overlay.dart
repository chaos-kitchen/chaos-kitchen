import 'dart:async';

import 'package:chaos_kitchen/components/button.dart';
import 'package:chaos_kitchen/components/snackbar.dart';
import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LobbyOverlay extends StatefulWidget {
  final ChaosKitchenGame game;

  const LobbyOverlay({super.key, required this.game});

  @override
  State<LobbyOverlay> createState() => _LobbyOverlayState();
}

class _LobbyOverlayState extends State<LobbyOverlay> {
  bool isLoadingRoom = true;
  bool isHost = false;
  String roomCode = "";
  List<String> players = [];

  Completer<void> websocketLockCompleter = Completer<void>();

  StreamSubscription<ServerToClientMessage>? _subscription;

  void handleMessage(ServerToClientMessage message) {
    switch (message.whichPayload()) {
      case ServerToClientMessage_Payload.lobbyUpdated:
        final lobbyUpdatedMessage = message.lobbyUpdated;
        setState(() {
          isLoadingRoom = false;
          isHost = lobbyUpdatedMessage.isHost;
          roomCode = lobbyUpdatedMessage.roomCode.toUpperCase();
          players = lobbyUpdatedMessage.playerNames;
        });
        break;

      case ServerToClientMessage_Payload.gameStarted:
        final gameStartedMessage = message.gameStarted;
        widget.game.resetGame(gameStartedMessage);
        widget.game.closeLobby();
        break;

      default:
        showErrorSnackbar(context, 'Received unknown message from server');
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    widget.game.websocket.lock = widget.game.websocket.lock.then((_) {
      if (!mounted) return null;

      _subscription = widget.game.websocket.stream.listen(
        handleMessage,
        onError: (error) {
          if (!mounted) return;
          showErrorSnackbar(context, 'WebSocket error: $error');
        },
      );

      return websocketLockCompleter.future;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
    websocketLockCompleter.complete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Room')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoadingRoom)
              CircularProgressIndicator()
            else ...[
              Text('Room Code: $roomCode'),
              SizedBox(height: 16),
              Text('Players:'),
              for (var player in players) Text(player),
              if (isHost) ...[
                SizedBox(height: 32),
                UIButton(
                  onPressed: () {
                    final message = ClientToServerMessage()
                      ..startGame = StartGameMessage();
                    widget.game.websocket.send(message);
                  },
                  child: Text('Start Game'),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

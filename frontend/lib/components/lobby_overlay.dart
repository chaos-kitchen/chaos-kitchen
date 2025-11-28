import 'dart:async';

import 'package:chaos_kitchen/components/button.dart';
import 'package:chaos_kitchen/components/snackbar.dart';
import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
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
  Map<String, PlayerRole> playerRoles = {};

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
          playerRoles = Map.fromEntries(
            lobbyUpdatedMessage.playerRoles.entries.map(
              (e) => MapEntry(e.key, e.value),
            ),
          );
          ;
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

  String getRoleDisplayName(PlayerRole? role) {
    switch (role) {
      case PlayerRole.PLAYER_ROLE_COOK:
        return 'Cook';
      case PlayerRole.PLAYER_ROLE_INSTRUCTOR:
        return 'Instructor';
      default:
        return 'Unknown';
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
              for (var player in players)
                Text('$player - ${getRoleDisplayName(playerRoles[player])}'),
              if (isHost) ...[
                SizedBox(height: 16),
                UIButton(
                  onPressed: () {
                    final message = ClientToServerMessage()
                      ..swapRoles = SwapRolesMessage();
                    widget.game.websocket.send(message);
                  },
                  child: Text('Swap Roles'),
                ),
                SizedBox(height: 8),
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

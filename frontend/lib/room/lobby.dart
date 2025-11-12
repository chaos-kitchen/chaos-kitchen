import 'package:chaos_kitchen/components/button.dart';
import 'package:chaos_kitchen/components/snackbar.dart';
import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:chaos_kitchen/utils/config.dart';
import 'package:chaos_kitchen/utils/prefs.dart';
import 'package:chaos_kitchen/utils/websocket_controller.dart';
import 'package:flutter/material.dart';

class LobbyRoomScreen extends StatefulWidget {
  final String roomId;
  final String playerName;
  final void Function(String gameRoomId, bool isHost) onGameStarted;

  const LobbyRoomScreen({
    super.key,
    required this.roomId,
    required this.playerName,
    required this.onGameStarted,
  });

  @override
  State<LobbyRoomScreen> createState() => _LobbyRoomScreenState();
}

class _LobbyRoomScreenState extends State<LobbyRoomScreen> {
  late WebSocketController _wsController;

  bool isLoadingRoom = true;
  bool isHost = false;
  String roomCode = "";
  List<String> players = [];

  Future<void> createWebSocketConnection() async {
    final clientId = await getClientIdFromPrefs();
    if (!mounted) return;

    final wsUrl = AppConfig.getLobbyWebSocketUri(
      lobbyRoomId: widget.roomId,
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
        widget.onGameStarted(gameStartedMessage.gameRoomId, isHost);
        break;

      default:
        showErrorSnackbar(context, 'Received unknown message from server');
        break;
    }
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
                    _wsController.sendMessage(message);
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

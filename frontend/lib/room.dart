import 'package:chaos_kitchen/components/snackbar.dart';
import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:chaos_kitchen/utils/websocket_controller.dart';
import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  final String roomId;

  const RoomScreen({super.key, required this.roomId});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late WebSocketController _wsController;

  bool isLoadingRoom = true;
  String roomCode = "";
  List<String> players = [];

  Future<void> createWebSocketConnection() async {
    final controller = WebSocketController(roomId: widget.roomId);
    await controller.initialize();
    if (!mounted) return;
    _wsController = controller;

    controller.stream.listen(handleMessage);

    // Join room
    final message = ClientToServerMessage()
      ..playerUpdated = PlayerUpdatedMessage(username: "player");
    _wsController.sendMessage(message);
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
        final capitalizedRoomCode = lobbyUpdatedMessage.roomCode.toUpperCase();
        final formattedRoomCode =
            '${capitalizedRoomCode.substring(0, 3)} ${capitalizedRoomCode.substring(3)}';
        setState(() {
          isLoadingRoom = false;
          roomCode = formattedRoomCode;
          players = lobbyUpdatedMessage.usernames;
        });
        break;
      default:
        showErrorSnackbar(context, 'Received unknown message from server');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Room: ${widget.roomId}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoadingRoom) CircularProgressIndicator(),
            if (!isLoadingRoom) ...[
              Text('Room Code: $roomCode'),
              SizedBox(height: 16),
              Text('Players:'),
              for (var player in players) Text(player),
            ],
          ],
        ),
      ),
    );
  }
}

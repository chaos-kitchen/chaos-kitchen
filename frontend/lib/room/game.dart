import 'package:chaos_kitchen/components/snackbar.dart';
import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:chaos_kitchen/utils/config.dart';
import 'package:chaos_kitchen/utils/prefs.dart';
import 'package:chaos_kitchen/utils/websocket_controller.dart';
import 'package:chaos_kitchen/game/world.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

class MyGame extends FlameGame {
  MyGame({required CookWorld world, required List<Component> children})
    : super(world: world, children: children);

  @override
  Future<void> onLoad() async {
    final background = SpriteComponent()
      ..sprite = await loadSprite('backgrounds/kitchen.png')
      ..size = size; // Make it fill the screen
    add(background);
  }
}

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
  late Sprite _useButtonSprite;

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

  Future<void> _loadAssets() async {
    _useButtonSprite = await Sprite.load('use_btn.png');
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    createWebSocketConnection();
    _loadAssets();
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
    return GameWidget(
      game: MyGame(
        world: CookWorld(),
        children: [
          HudButtonComponent(
            button: SpriteComponent(
              sprite: _useButtonSprite,
              anchor: Anchor.topLeft,
              size: Vector2.all(100),
            ),
            margin: EdgeInsets.only(right: 20, bottom: 20),
            onPressed: () {
              print('Button pressed!');
            },
          ),
        ],
      ),
    );
  }
}

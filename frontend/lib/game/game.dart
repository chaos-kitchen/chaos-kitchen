import 'dart:ui';

import 'package:chaos_kitchen/game/cook_world.dart';
import 'package:chaos_kitchen/game/instructor_world.dart';
import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:chaos_kitchen/utils/config.dart';
import 'package:chaos_kitchen/utils/prefs.dart';
import 'package:chaos_kitchen/utils/websocket_controller.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:chaos_kitchen/game/actors/player.dart';

class ChaosKitchenGame extends FlameGame with HasCollisionDetection {
  final String roomId;
  final String playerName;

  late final Uri _websocketUrl;
  late WebSocketController websocket;
  Player? cookPlayer;

  @override
  Color backgroundColor() {
    return const Color(0xffe3dfde);
  }

  ChaosKitchenGame({required this.roomId, required this.playerName});

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;

    final clientId = await getClientIdFromPrefs();

    _websocketUrl = await AppConfig.getGameWebSocketUri(
      gameRoomId: roomId,
      clientId: clientId,
      playerName: playerName,
    );

    openLobby();
  }

  @override
  void onMount() async {
    super.onMount();
    websocket = WebSocketController(_websocketUrl);
    await websocket.connect();
  }

  @override
  void onRemove() async {
    super.onRemove();
    await websocket.dispose();
  }

  void resetGame(GameStartedMessage gameStartedMessage) {
    final initialPlayerPosition = Vector2(
      gameStartedMessage.initialPosition.x,
      gameStartedMessage.initialPosition.y,
    );
    final role = gameStartedMessage.role;

    switch (role) {
      case PlayerRole.PLAYER_ROLE_COOK:
        world = CookWorld(
          initialPlayerPosition: initialPlayerPosition,
          initialHeldItemId: gameStartedMessage.heldItemId,
        );
        break;
      case PlayerRole.PLAYER_ROLE_INSTRUCTOR:
        world = InstructorWorld(
          initialPlayerPosition: initialPlayerPosition,
          initialHeldItemId: gameStartedMessage.heldItemId == ''
              ? null
              : gameStartedMessage.heldItemId,

          gameEndTime: gameStartedMessage.endTime.toDateTime(),
        );
        break;
      default:
        throw UnimplementedError("Unknown player role: $role");
    }
  }

  void openPauseMenu() {
    overlays.add('pause_overlay');
  }

  void closePauseMenu() {
    overlays.remove('pause_overlay');
  }

  void openLobby() {
    pauseEngine();
    overlays.add('lobby_overlay');
  }

  void closeLobby() {
    overlays.remove('lobby_overlay');
    resumeEngine();
  }

  void openFridge() {
    pauseEngine();
    overlays.add('fridge_overlay');
  }

  void closeFridge() {
    overlays.remove('fridge_overlay');
    resumeEngine();
  }

  void openPantry() {
    pauseEngine();
    overlays.add('pantry_overlay');
  }

  void closePantry() {
    overlays.remove('pantry_overlay');
    resumeEngine();
  }
}

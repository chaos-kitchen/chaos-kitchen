import 'package:chaos_kitchen/game/cook_world.dart';
import 'package:chaos_kitchen/game/instructor_world.dart';
import 'package:chaos_kitchen/protobuf/websocket.pbenum.dart';
import 'package:chaos_kitchen/utils/config.dart';
import 'package:chaos_kitchen/utils/prefs.dart';
import 'package:chaos_kitchen/utils/websocket_controller.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:chaos_kitchen/game/actors/player.dart';

class ChaosKitchenGame extends FlameGame with HasCollisionDetection {
  final String roomId;
  final String playerName;

  ChaosKitchenGame({required this.roomId, required this.playerName});

  late final WebSocketController websocket;

  Player? cookPlayer;

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;

    final clientId = await getClientIdFromPrefs();

    final wsUrl = await AppConfig.getGameWebSocketUri(
      gameRoomId: roomId,
      clientId: clientId,
      playerName: playerName,
    );

    websocket = WebSocketController(wsUrl);
    openLobby();
  }

  @override
  void onMount() async {
    super.onMount();
    await websocket.initialize();
    await Flame.device.fullScreen();
  }

  @override
  void onRemove() async {
    super.onRemove();
    websocket.dispose();
    await Flame.device.restoreFullscreen();
  }

  void switchRole(PlayerRole newRole, DateTime gameEndTime) {
    world.removeFromParent();
    switch (newRole) {
      case PlayerRole.PLAYER_ROLE_COOK:
        world = CookWorld();
        break;
      case PlayerRole.PLAYER_ROLE_INSTRUCTOR:
        world = InstructorWorld(gameEndTime: gameEndTime);
        break;
      default:
        throw UnimplementedError("Unknown player role: $newRole");
    }
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

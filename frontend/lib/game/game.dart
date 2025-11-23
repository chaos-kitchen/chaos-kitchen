import 'package:chaos_kitchen/game/cook_world.dart';
import 'package:chaos_kitchen/game/instructor_world.dart';
import 'package:chaos_kitchen/protobuf/websocket.pbenum.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class ChaosKitchenGame extends FlameGame with HasCollisionDetection {
  final Future<PlayerRole> _roleFuture;

  ChaosKitchenGame(this._roleFuture);

  late final PlayerRole playerRole;

  @override
  Future<void> onLoad() async {
    playerRole = await _roleFuture;
    switch (playerRole) {
      case PlayerRole.PLAYER_ROLE_COOK:
        world = CookWorld();
        break;
      case PlayerRole.PLAYER_ROLE_INSTRUCTOR:
        world = InstructorWorld();
        break;
      default:
        throw UnimplementedError("Unknown player role: $playerRole");
    }

    camera.viewfinder.anchor = Anchor.topLeft;
  }

  @override
  void onMount() async {
    super.onMount();
    await Flame.device.fullScreen();
  }

  @override
  void onRemove() async {
    super.onRemove();
    await Flame.device.restoreFullscreen();
  }
}

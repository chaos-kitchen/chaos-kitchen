import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/viewport.dart';
import 'package:flame/components.dart';

class CookWorld extends World with HasGameReference<ChaosKitchenGame> {
  @override
  Future<void> onLoad() async {
    final player = Player(position: Vector2(0, 0));
    add(player);
    game.camera.viewport = PlayerViewport(player);
  }
}

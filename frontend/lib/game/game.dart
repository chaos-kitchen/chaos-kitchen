import 'package:chaos_kitchen/game/cook_world.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class ChaosKitchenGame extends FlameGame {
  ChaosKitchenGame() : super(world: CookWorld());

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;

    const scaleFactor = 1.5; // larger value = more zoomed in
    final background = SpriteComponent()
      ..sprite = await loadSprite('backgrounds/kitchen.png')
      ..size = size * scaleFactor
      ..anchor = Anchor.topLeft
      ..position = -((size * scaleFactor - size) / 2);
    add(background);
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

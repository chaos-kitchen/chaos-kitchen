import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/viewport.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class InstructorWorld extends World
    with HasGameReference<ChaosKitchenGame>, TapCallbacks {
  @override
  Future<void> onLoad() async {
    final gameBounds = Vector2(32 * 30, 32 * 20);
    const scaleFactor = 1.6; // larger value = more zoomed in
    final background = SpriteComponent()
      ..sprite = await game.loadSprite('backgrounds/customer_area.png')
      ..size = gameBounds * scaleFactor
      ..anchor = Anchor.topLeft
      ..position = Vector2(-32 * 12, -32 * 5.5);
    add(background);

    final animation = SpriteAnimation.fromFrameData(
      await game.images.load('instructor.png'),
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: Vector2.all(400),
        stepTime: 0.12,
      ),
    );
    final player = Player(
      position: Vector2(400.0, 200.0),
      animation: animation,
    );
    add(player);

    game.camera.viewport = PlayerViewport(player);
    game.camera.viewfinder.visibleGameSize = gameBounds;
    game.camera.viewfinder.position = gameBounds / 2;
    game.camera.viewfinder.anchor = Anchor.center;
  }

  // TEMP: temporarily print tap positions for creating hitboxes
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    final position = event.localPosition;
    print(
      'Vector2(${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}),',
    );
  }
}

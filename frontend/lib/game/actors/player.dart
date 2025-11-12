import 'package:chaos_kitchen/game/game.dart';
import 'package:flame/components.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<ChaosKitchenGame> {
  Player({super.position})
    : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      await game.images.load('cook.png'),
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: Vector2.all(400),
        stepTime: 0.12,
      ),
    );
  }
}

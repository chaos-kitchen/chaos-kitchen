import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/objects.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<ChaosKitchenGame>, CollisionCallbacks {
  Player({super.position})
    : super(size: Vector2.all(64), anchor: Anchor.center, priority: 2);

  @override
  void onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      await game.images.load('cook.png'),
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: Vector2.all(400),
        stepTime: 0.12,
      ),
    );

    add(CircleHitbox(collisionType: CollisionType.active));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    // Collision code taken from:
    // https://docs.flame-engine.org/latest/tutorials/platformer/step_5.html
    if (other is SolidObjectHitbox) {
      if (intersectionPoints.length == 2) {
        // Calculate the collision normal and separation distance.
        final mid =
            (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        // Resolve collision by moving ember along
        // collision normal by separation distance.
        position += collisionNormal.scaled(separationDistance);
      }
    }
  }
}

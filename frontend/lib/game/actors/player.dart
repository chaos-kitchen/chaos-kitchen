import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/objects.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/painting.dart';
import 'dart:math' as math;

class Player extends PositionComponent
    with HasGameReference<ChaosKitchenGame>, CollisionCallbacks {
  Player({super.position})
    : super(size: Vector2.all(64), anchor: Anchor.center, priority: 2);

  late SpriteComponent playerSprite;

  @override
  Future<void> onLoad() async {
    final spriteSheet = await game.images.load('cook_2.png');

    final spriteSize = Vector2(
      spriteSheet.width / 4,
      spriteSheet.height.toDouble(),
    );

    // add the shadow first
    add(
      CircleComponent(
        radius: 23,
        position: Vector2(6, -7), // Top-right offset (negative Y is up)
        anchor: Anchor.center,
        paint: Paint()
          ..color = const Color(0x33000000)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      ),
    );

    // add the player sprite over the shadow
    playerSprite = SpriteComponent(
      sprite: Sprite(
        spriteSheet,
        srcPosition: Vector2(0, 0),
        srcSize: spriteSize,
      ),
      size: size,
      anchor: Anchor.center,
    );
    add(playerSprite);
  }

  void updateDirection(Vector2 velocity) {
    if (velocity.isZero()) return;

    // Calculate the angle of movement in radians
    final movementAngle = math.atan2(velocity.y, velocity.x);
    playerSprite.angle = movementAngle - (math.pi / 2); // rotate by 90 degrees
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

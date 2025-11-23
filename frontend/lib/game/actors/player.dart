import 'dart:ui';

import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';
import 'package:chaos_kitchen/game/objects/solid_object.dart';
import 'package:chaos_kitchen/utils/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<ChaosKitchenGame>, CollisionCallbacks {
  Player({super.position, super.animation})
    : super(size: Vector2.all(64), anchor: Anchor.center, priority: 2);

  List<InteractableObject> interactableObjectsInRange = [];

  @override
  void onLoad() async {
    add(CircleHitbox(radius: size.x / 2, collisionType: CollisionType.active));

    if (AppConfig.showDebugCollisionBoxes) {
      add(
        CircleComponent(
          radius: size.x / 2,
          paint: Paint()..color = const Color(0x770000FF),
        ),
      );
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
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

    if (other is InteractableObject) {
      interactableObjectsInRange.add(other);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);
    interactableObjectsInRange = [];
  }
}

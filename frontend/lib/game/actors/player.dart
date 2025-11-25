import 'dart:ui';

import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';
import 'package:chaos_kitchen/game/objects/solid_object.dart';
import 'package:chaos_kitchen/utils/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart'; // for ValueNotifier
import 'package:flame/extensions.dart';
import 'package:flutter/painting.dart';
import 'dart:math' as math;

class Player extends PositionComponent
    with HasGameReference<ChaosKitchenGame>, CollisionCallbacks {
  Player({super.position, required this.sprite})
    : super(size: Vector2.all(64), anchor: Anchor.center, priority: 2);

  final Sprite sprite;
  late SpriteComponent playerSprite;

  final Vector2 velocity = Vector2.zero();
  double maxSpeed = 400; // top speed (match old joystick)
  double acceleration = 800; // how fast to reach target speed
  double friction = 600;

  /// Interactable objects currently overlapping the player.
  final List<InteractableObject> interactablesInRange = [];

  InteractableObject? get closestInteractable {
    if (interactablesInRange.isEmpty) return null;

    InteractableObject closest = interactablesInRange.first;
    for (final obj in interactablesInRange) {
      if (obj.position.distanceTo(position) <
          closest.position.distanceTo(position)) {
        closest = obj;
      }
    }
    return closest;
  }

  /// Increment this whenever the collision set changes, so listeners
  /// know to recompute the closest interactable.
  final ValueNotifier<int> interactablesUpdatedNotifier = ValueNotifier<int>(0);

  @override
  void onLoad() async {
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

    playerSprite = SpriteComponent(
      sprite: sprite,
      size: size,
      anchor: Anchor.center,
    );
    add(playerSprite);

    add(
      CircleHitbox(
        radius: size.x / 2,
        anchor: Anchor.center,
        collisionType: CollisionType.active,
      ),
    );

    if (AppConfig.showDebugCollisionBoxes) {
      add(
        CircleComponent(
          radius: size.x / 2,
          anchor: Anchor.center,
          paint: Paint()..color = const Color(0x770000FF),
        ),
      );
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    // Existing wall collision resolution
    if (other is SolidObjectHitbox) {
      if (intersectionPoints.length == 2) {
        final mid =
            (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;

        final hitboxCenter = absoluteCenter - (size / 2);
        final collisionNormal = hitboxCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();
        position += collisionNormal.scaled(separationDistance);
      }
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is InteractableObject && !interactablesInRange.contains(other)) {
      interactablesInRange.add(other);
      interactablesUpdatedNotifier.value++;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is InteractableObject) {
      interactablesInRange.remove(other);
      interactablesUpdatedNotifier.value++;
    }
  }

  void applyInput(Vector2 input, double dt) {
    if (!input.isZero()) {
      final desired = input.normalized() * maxSpeed;

      final delta = desired - velocity;
      final dist = delta.length;
      final maxDelta = acceleration * dt;
      if (dist <= maxDelta || dist == 0) {
        velocity.setFrom(desired);
      } else {
        delta.normalize();
        velocity.add(delta.scaled(maxDelta));
      }
    } else {
      final speed = velocity.length;
      if (speed > 0) {
        final decel = friction * dt;
        if (decel >= speed) {
          velocity.setZero();
        } else {
          velocity.scale((speed - decel) / speed);
        }
      }
    }

    position += velocity * dt;

    updateDirection(velocity);
  }

  void updateDirection(Vector2 velocity) {
    if (velocity.isZero()) return;

    // Calculate the angle of movement in radians
    final movementAngle = math.atan2(velocity.y, velocity.x);
    playerSprite.angle = movementAngle - (math.pi / 2);
  }
}

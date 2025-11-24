import 'dart:ui';

import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';
import 'package:chaos_kitchen/game/objects/solid_object.dart';
import 'package:chaos_kitchen/utils/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart'; // for ValueNotifier

class Player extends SpriteAnimationComponent
    with HasGameReference<ChaosKitchenGame>, CollisionCallbacks {
  Player({super.position, super.animation})
    : super(size: Vector2.all(64), anchor: Anchor.center, priority: 2);

  List<InteractableObject> interactableObjectsInRange = [];

  /// Interactable objects currently overlapping the player.
  final List<InteractableObject> interactablesInRange = [];

  /// Increment this whenever the collision set changes, so listeners
  /// know to recompute the closest interactable.
  final ValueNotifier<int> collisionsCompletedNotifier = ValueNotifier<int>(0);

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
    super.onCollision(intersectionPoints, other);
    // Existing wall collision resolution
    if (other is SolidObjectHitbox) {
      if (intersectionPoints.length == 2) {
        final mid =
            (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;

        final collisionNormal = absoluteCenter - mid;
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
      collisionsCompletedNotifier.value++;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is InteractableObject) {
      interactablesInRange.remove(other);
      collisionsCompletedNotifier.value++;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    interactableObjectsInRange = [];
  }
}

import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:chaos_kitchen/game/actors/player.dart';

abstract class InteractableObject extends PositionComponent {
  final bool useRectangle;
  final Vector2? rectSize; // optional size for rectangular hitbox
  final double? radius; // optional radius for circle hitbox

  InteractableObject({
    required super.position,
    this.useRectangle = false,
    this.rectSize,
    this.radius,
  }) : super(anchor: Anchor.center);

  /// Called when the player presses the interact button while this
  /// object is the closest interactable.
  void interact(Player player);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // A shared paint style for outlines
    final outlinePaint = Paint()
      ..color =
          const Color(0x8800FF00) // semi-transparent light green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    if (useRectangle) {
      assert(rectSize != null, 'rectSize is required when useRectangle=true');
      size = rectSize!;

      final rectHitbox = RectangleHitbox()
        ..collisionType = CollisionType.passive
        ..renderShape = true
        ..paint = outlinePaint; // 👈 outline-only

      add(rectHitbox);
    } else {
      assert(radius != null, 'radius is required when useRectangle=false');
      size = Vector2.all(radius! * 2);

      final circleHitbox = CircleHitbox()
        ..collisionType = CollisionType.passive
        ..renderShape = true
        ..paint = outlinePaint; // 👈 outline-only

      add(circleHitbox);
    }
  }
}

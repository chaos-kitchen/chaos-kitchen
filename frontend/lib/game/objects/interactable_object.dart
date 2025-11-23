import 'dart:async';
import 'dart:ui';

import 'package:chaos_kitchen/utils/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

abstract class InteractableObject extends CircleComponent {
  InteractableObject({required super.position, required super.radius})
    : super(
        anchor: Anchor.center,
        paint: Paint()
          ..color = AppConfig.showDebugCollisionBoxes
              ? const Color(0x7700FF00)
              : const Color(0x00000000)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5,
      );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(
      CircleHitbox(
        position: position,
        radius: radius,
        collisionType: CollisionType.passive,
        isSolid: true,
      ),
    );
  }
}

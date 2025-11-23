import 'dart:async';
import 'dart:ui';

import 'package:chaos_kitchen/utils/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class SolidObjectHitbox extends PolygonComponent {
  SolidObjectHitbox(super.vertices)
    : super(
        paint: Paint()
          ..color = AppConfig.showDebugCollisionBoxes
              ? const Color(0x77FF0000)
              : const Color(0x00000000)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5,
      );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(
      PolygonHitbox(
        vertices,
        collisionType: CollisionType.passive,
        isSolid: true,
      ),
    );
  }
}

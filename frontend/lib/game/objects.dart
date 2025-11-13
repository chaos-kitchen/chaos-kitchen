import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class SolidObjectHitbox extends PolygonComponent {
  SolidObjectHitbox(super.vertices)
    : super(
        paint: Paint()
          // semi-transparent red for debugging
          ..color = const Color(0x77FF0000)
          // ..color =
          //     const Color(0x00000000) // invisible color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5,
      );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    add(PolygonHitbox(vertices, collisionType: CollisionType.passive));
  }
}

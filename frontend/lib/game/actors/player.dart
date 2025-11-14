import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/objects.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:math' as math;

enum PlayerDirection { up, down, left, right }

class Player extends SpriteComponent
    with HasGameReference<ChaosKitchenGame>, CollisionCallbacks {
  Player({super.position})
    : super(size: Vector2.all(64), anchor: Anchor.center, priority: 2);

  late final Sprite downSprite;
  late final Sprite upSprite;
  late final Sprite leftSprite;
  late final Sprite rightSprite;

  PlayerDirection currentDirection = PlayerDirection.down;

  @override
  Future<void> onLoad() async {
    final spriteSheet = await game.images.load('cook_2.png');

    final spriteSize = Vector2(
      spriteSheet.width / 4,
      spriteSheet.height.toDouble(),
    );

    downSprite = Sprite(
      spriteSheet,
      srcPosition: Vector2(0, 0),
      srcSize: spriteSize,
    );

    rightSprite = Sprite(
      spriteSheet,
      srcPosition: Vector2(spriteSize.x, 0),
      srcSize: spriteSize,
    );

    upSprite = Sprite(
      spriteSheet,
      srcPosition: Vector2(spriteSize.x * 2, 0),
      srcSize: spriteSize,
    );

    leftSprite = Sprite(
      spriteSheet,
      srcPosition: Vector2(spriteSize.x * 3, 0),
      srcSize: spriteSize,
    );

    sprite = downSprite;
  }

  void updateDirection(Vector2 velocity) {
    if (velocity.isZero()) return;

    // Calculate the angle of movement in radians
    final movementAngle = math.atan2(velocity.y, velocity.x);

    // Convert to degrees for easier understanding
    final degrees = movementAngle * 180 / math.pi;

    // Determine which quadrant and apply rotation
    PlayerDirection newDirection;
    double rotationOffset;

    if (degrees >= -45 && degrees < 45) {
      // Right: -45° to 45°
      newDirection = PlayerDirection.right;
      rotationOffset = movementAngle;
    } else if (degrees >= 45 && degrees < 135) {
      // Down: 45° to 135°
      newDirection = PlayerDirection.down;
      rotationOffset = movementAngle - (math.pi / 2);
    } else if (degrees >= -135 && degrees < -45) {
      // Up: -135° to -45°
      newDirection = PlayerDirection.up;
      rotationOffset = movementAngle + (math.pi / 2);
    } else {
      // Left: 135° to 180° and -180° to -135°
      newDirection = PlayerDirection.left;
      // Handle wrapping around ±180°
      if (degrees > 0) {
        rotationOffset = movementAngle - math.pi;
      } else {
        rotationOffset = movementAngle + math.pi;
      }
    }

    setDirection(newDirection);

    // Clamp rotation to ±45 degrees (±π/4 radians)
    rotationOffset.clamp(-math.pi / 4, math.pi / 4);
  }

  void setDirection(PlayerDirection direction) {
    if (currentDirection == direction) return;

    currentDirection = direction;
    switch (direction) {
      case PlayerDirection.up:
        sprite = upSprite;
        break;
      case PlayerDirection.down:
        sprite = downSprite;
        break;
      case PlayerDirection.left:
        sprite = leftSprite;
        break;
      case PlayerDirection.right:
        sprite = rightSprite;
        break;
    }
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

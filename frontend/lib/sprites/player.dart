import 'package:flame/components.dart';

enum PlayerRole { cook, instructor }

class Player extends SpriteComponent {
  final PlayerRole role;

  Player({required this.role, Vector2? position})
    : super(
        position: position ?? Vector2.zero(),
        size: Vector2.all(75),
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      role == PlayerRole.cook ? 'players/cook.png' : 'players/instructor.png',
    );
  }
}

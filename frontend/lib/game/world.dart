import 'package:flame/components.dart';
import 'package:chaos_kitchen/sprites/player.dart';

class CookWorld extends World {
  @override
  Future<void> onLoad() async {
    await add(Player(role: PlayerRole.cook));
  }
}

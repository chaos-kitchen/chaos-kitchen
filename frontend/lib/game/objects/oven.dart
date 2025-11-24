import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';

class OvenObject extends InteractableObject {
  // OvenObject({required super.position, required super.radius});
  OvenObject({required super.position, required double radius})
    : super(radius: radius, useRectangle: false);

  @override
  void interact(Player player) {
    // For now, just something visible in the debug console.
    // Later, this will open oven minigame / overlay.
    // (can also call a method on game here if you add HasGameReference.)
    // ignore: avoid_print
    print('Oven interacted with by player at ${player.position}');
  }
}

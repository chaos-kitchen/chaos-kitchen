import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';

class GarbageObject extends InteractableObject {
  // OvenObject({required super.position, required super.radius});
  GarbageObject({required super.position, required double radius})
    : super(radius: radius, useRectangle: false);

  @override
  void interact(Player player) {
    // For now, just something visible in the debug console.
    print('Garbage interacted with by player at ${player.position}');

    // If the cook is holding something, drop it (discard it).
    if (player.hasHeldItem) {
      player.dropHeldItem();
    }
  }
}

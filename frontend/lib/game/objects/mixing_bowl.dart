import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';

class MixingBowlObject extends InteractableObject {
  // OvenObject({required super.position, required super.radius});
  MixingBowlObject({required super.position, required double radius})
    : super(radius: radius, useRectangle: false);

  @override
  void interact(Player player) {
    // For now, just something visible in the debug console.
    print('Mixing Bowl interacted with by player at ${player.position}');

    // Open the dough mixer overlay when the cook presses USE
    game.openDoughMixer();
  }
}

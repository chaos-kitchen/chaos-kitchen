import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';

class CuttingBoardObject extends InteractableObject {
  // CuttingBoardObject({required super.position, required super.radius});
  CuttingBoardObject({required super.position, required double radius})
    : super(radius: radius, useRectangle: false);

  @override
  void interact(Player player) {
    // For now, just log
    print('Cutting board interacted with by player at ${player.position}');

    game.openChopping();
  }
}

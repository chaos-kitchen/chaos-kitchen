import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';
import 'package:flame/components.dart';

class AppliancesShelfObject extends InteractableObject {
  AppliancesShelfObject({required super.position, required Vector2 size})
    : super(useRectangle: true, rectSize: size);

  @override
  void interact(Player player) {
    // For now, just a debug log.
    print('Appliances shelf interacted with by player at ${player.position}');
  }
}

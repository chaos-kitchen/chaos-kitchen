import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/ingredients.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';

class CoalPileObject extends InteractableObject {
  CoalPileObject({required super.position, required double radius})
    : super(radius: radius, useRectangle: false);

  @override
  void interact(Player player) {
    player.tryPickItem(IngredientIds.coal);
  }
}

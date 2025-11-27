import 'package:chaos_kitchen/components/furnace_overlay.dart';
import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';

class FurnaceObject extends InteractableObject {
  String? heldItemId;

  FurnaceObject({required super.position, required double radius})
    : super(radius: radius, useRectangle: false);

  @override
  void interact(Player player) {
    game.openFurnace(FurnaceOverlayArgs(player: player, furnace: this));
  }
}

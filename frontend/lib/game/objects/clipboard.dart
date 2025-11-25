import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';

class ClipboardObject extends InteractableObject {
  ClipboardObject({required super.position, required double radius})
    : super(radius: radius, useRectangle: false);

  @override
  void interact(Player player) {
    // For now just log it
    print('Clipboard interacted with by player at ${player.position}');
  }
}

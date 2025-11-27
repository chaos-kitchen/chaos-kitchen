import 'package:chaos_kitchen/components/furnace_overlay.dart';
import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';
import 'package:flutter/material.dart';

class FurnaceObject extends InteractableObject {
  final heldItemNotifier = ValueNotifier<String?>(null);
  final fuelRemainingSecondsNotifier = ValueNotifier<int>(0);

  static const int maxFuelSeconds = 20;

  FurnaceObject({required super.position, required double radius})
    : super(radius: radius, useRectangle: false);

  @override
  void interact(Player player) {
    game.openFurnace(FurnaceOverlayArgs(player: player, furnace: this));
  }
}

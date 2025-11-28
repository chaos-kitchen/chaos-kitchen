import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/mixins/fuel.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';
import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class OvenObject extends InteractableObject with FuelTimerMixin {
  final fuelProgressNotifier = ValueNotifier<double>(0);

  // OvenObject({required super.position, required super.radius});
  OvenObject({required super.position, required double radius})
    : super(radius: radius, useRectangle: false);

  void onOvenPowered(OvenPoweredMessage message) {
    startFuelTimer(message, fuelProgressNotifier);
    addFaintGlowEffect(message, Vector2(30, 50), 20);
  }

  @override
  void interact(Player player) {
    // For now, just something visible in the debug console.
    // Later, this will open oven minigame / overlay.
    // (can also call a method on game here if you add HasGameReference.)
    // ignore: avoid_print
    print('Oven interacted with by player at ${player.position}');
  }
}

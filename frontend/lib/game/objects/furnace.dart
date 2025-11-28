import 'package:chaos_kitchen/components/furnace_overlay.dart';
import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/mixins/fuel.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';
import 'package:chaos_kitchen/protobuf/websocket.pb.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

class FurnaceObject extends InteractableObject with FuelTimerMixin {
  final heldItemNotifier = ValueNotifier<String?>(null);
  // fuel remaining in seconds
  final fuelProgressNotifier = ValueNotifier<double>(0);

  FurnaceObject({required super.position, required super.radius})
    : super(useRectangle: false);

  void onOvenPowered(OvenPoweredMessage message) {
    startFuelTimer(message, fuelProgressNotifier);
    addFaintGlowEffect(message, Vector2(90, 50), 20);
  }

  void onHeldItemChanged() {
    // if no item is held, do nothing
    if (heldItemNotifier.value == null) return;

    heldItemNotifier.value = null;

    // Server will notify all clients that the furnace is powered
    final now = Timestamp.fromDateTime(DateTime.now().toUtc());
    final message = ClientToServerMessage()
      ..furnacePowered = FurnacePoweredMessage(poweredAt: now);
    game.websocket.send(message);
  }

  @override
  void onMount() {
    super.onMount();
    heldItemNotifier.addListener(onHeldItemChanged);
  }

  @override
  void onRemove() {
    super.onRemove();
    heldItemNotifier.removeListener(onHeldItemChanged);
  }

  @override
  void interact(Player player) {
    game.openFurnace(FurnaceOverlayArgs(player: player, furnace: this));
  }
}

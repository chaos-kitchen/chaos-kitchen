import 'dart:async';

import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';

class PlayerViewport extends MaxViewport
    with HasGameReference<ChaosKitchenGame> {
  final Player player;

  PlayerViewport(this.player);

  @override
  void onLoad() async {
    super.onLoad();

    add(
      PlayerJoystick(
        player: player,
        margin: const EdgeInsets.only(left: 40, bottom: 40),
      ),
    );

    var isInteractButtonShown = false;
    InteractableObject? currentInteractable;

    // Interact button (callback added later)
    final interactButton = HudInteractButton(
      margin: const EdgeInsets.only(right: 40, bottom: 40),
      onPressed: () {
        if (currentInteractable != null) {
          print('Interact pressed: ${currentInteractable.runtimeType}');
          currentInteractable!.interact(player);
        } else {
          print('Interact pressed, but no interactable in range');
        }
      },
    );

    // Listen for when player collision set changes
    player.interactablesUpdatedNotifier.addListener(() {
      currentInteractable = player.closestInteractable;
      if (currentInteractable != null && !isInteractButtonShown) {
        add(interactButton);
        isInteractButtonShown = true;
      } else {
        remove(interactButton);
        isInteractButtonShown = false;
      }
    });
  }
}

class PlayerJoystick extends JoystickComponent {
  final Player player;
  final double maxSpeed = 200.0;

  PlayerJoystick({required this.player, required super.margin})
    : super(
        knobRadius: 30,
        knob: CircleComponent(
          radius: 30,
          paintLayers: [
            Paint()..color = const Color(0xFF888888),
            Paint()
              ..color = const Color(0xFF444444)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4,
          ],
        ),
        background: CircleComponent(
          radius: 60,
          paintLayers: [
            Paint()..color = const Color(0x55000000),
            Paint()
              ..color = const Color(0xAA000000)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4,
          ],
        ),
      );

  @override
  void update(double dt) {
    super.update(dt);
    if (direction != JoystickDirection.idle) {
      player.position.add(relativeDelta * maxSpeed * dt);
    }
  }
}

class HudInteractButton extends HudButtonComponent {
  HudInteractButton({required super.margin, required super.onPressed})
    : super(size: Vector2.all(60));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    button = CircleComponent(
      radius: 30,
      paintLayers: [
        Paint()..color = const Color(0xFF888888),
        Paint()
          ..color = const Color(0xFF444444)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4,
      ],
    );
  }
}

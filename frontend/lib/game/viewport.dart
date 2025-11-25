import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/hud/hud_interact_button.dart';
import 'package:chaos_kitchen/game/objects/interactable_object.dart';
import 'package:flutter/material.dart';
import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';

class PlayerViewport extends MaxViewport
    with HasGameReference<ChaosKitchenGame> {
  final bool showTimer;
  final Player player;

  PlayerViewport({required this.player, required this.showTimer});

  @override
  void onLoad() async {
    super.onLoad();

    add(
      PlayerJoystick(
        player: player,
        margin: const EdgeInsets.only(left: 40, bottom: 40),
      ),
    );

    InteractableObject? currentInteractable;

    // Interact button (callback added later)
    final interactButton = HudInteractButton(
      margin: const EdgeInsets.only(right: 40, bottom: 40),
      onPressWhenActive: () {
        if (currentInteractable != null) {
          print('Interact pressed: ${currentInteractable.runtimeType}');
          currentInteractable!.interact(player);
        } else {
          print('Interact pressed, but no interactable in range');
        }
      },
    );
    add(interactButton);

    // Listen for when player collision set changes
    player.interactablesUpdatedNotifier.addListener(() {
      currentInteractable = player.closestInteractable;
      interactButton.isActive = currentInteractable != null;
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
      player.updateDirection(relativeDelta);
    }
  }
}

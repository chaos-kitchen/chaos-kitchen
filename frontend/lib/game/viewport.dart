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
    final interactButton = HudInteractButton(
      margin: const EdgeInsets.only(right: 40, bottom: 40),
    );
    add(interactButton);

    var isInteractButtonShown = false;
    // game.collisionDetection.collisionsCompletedNotifier.addListener(() {
    //   print(
    //     'Interactable objects in range: ${player.interactableObjectsInRange.length}',
    //   )
    //   if (player.interactableObjectsInRange.isEmpty && isInteractButtonShown) {
    //     isInteractButtonShown = false;
    //     // interactButton.removeFromParent();
    //   }
    //
    //   if (player.interactableObjectsInRange.isNotEmpty &&
    //       !isInteractButtonShown) {
    //     isInteractButtonShown = true;
    //     interactButton.interactableObject = _getClosestInteractableObject(
    //       player.interactableObjectsInRange,
    //     );
    //     // add(interactButton);
    //   }
    // });
  }

  InteractableObject _getClosestInteractableObject(
    List<InteractableObject> objects,
  ) {
    InteractableObject closest = objects.first;
    for (final obj in objects) {
      if (obj.position.distanceTo(player.position) <
          closest.position.distanceTo(player.position)) {
        closest = obj;
      }
    }
    return closest;
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
  late InteractableObject interactableObject;

  HudInteractButton({required super.margin}) : super(size: Vector2.all(60));

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
    onPressed = () {
      print('Interact button pressed');
      print('Interactable objects in range: ${interactableObject.runtimeType}');
    };
  }
}

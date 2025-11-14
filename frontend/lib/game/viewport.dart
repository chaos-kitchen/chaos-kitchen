import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';

class PlayerViewport extends MaxViewport {
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
    add(
      HudInteractButton(margin: const EdgeInsets.only(right: 40, bottom: 40)),
    );
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

class HudInteractButton extends HudButtonComponent {
  HudInteractButton({required super.margin})
    : super(
        button: CircleComponent(
          radius: 30,
          paintLayers: [
            Paint()..color = const Color(0xFF888888),
            Paint()
              ..color = const Color(0xFF444444)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4,
          ],
        ),
        size: Vector2.all(60),
      );
}

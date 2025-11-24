import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class HudInteractButton extends HudButtonComponent {
  final void Function() onPressWhenActive;

  HudInteractButton({required super.margin, required this.onPressWhenActive})
    : super(size: Vector2.all(80));

  late final SpriteComponent? buttonSprite;

  bool _isActive = false;
  Color _color = Colors.grey.withValues(alpha: 0.5);

  set isActive(bool value) {
    if (_isActive == value) return;
    _isActive = value;

    if (value) {
      _color = Colors.white;
      onPressed = onPressWhenActive;
    } else {
      _color = Colors.grey.withValues(alpha: 0.5);
      onPressed = null;
    }

    buttonSprite?.paint.color = _color;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final sprite = await game.loadSprite('use_btn.png');

    buttonSprite = SpriteComponent(
      sprite: sprite,
      size: size - Vector2.all(14),
      position: Vector2(7, 10),
      paint: Paint()..color = _color,
    );

    button = CircleComponent(
      radius: size.x / 2,
      paintLayers: [Paint()..color = const Color(0x55777777)],
      children: [buttonSprite!],
    );
  }
}

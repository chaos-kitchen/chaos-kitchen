import 'dart:async';
import 'dart:ui' show Paint;

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

    // Inventory HUD slot – positioned above the interact button.
    add(
      HudInventorySlot(
        player: player,
        margin: const EdgeInsets.only(right: 40, bottom: 40 + 60 + 12),
      ),
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

class HudInventorySlot extends HudMarginComponent
    with HasGameReference<ChaosKitchenGame> {
  final Player player;

  HudInventorySlot({required this.player, required super.margin})
    : super(anchor: Anchor.bottomRight);

  late RectangleComponent _border;
  late TextComponent _emptyText;
  SpriteComponent? _itemSprite;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = Vector2.all(60);

    // Same color as before (semi-transparent white)
    const borderColor = Color(0x55FFFFFF);

    // Border only (no fill)
    _border = RectangleComponent(
      size: size,
      anchor: Anchor.center,
      position: size / 2,
      paint: Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
    add(_border);

    // Centered "empty" text
    _emptyText = TextComponent(
      text: 'empty',
      anchor: Anchor.center,
      position: size / 2,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: borderColor, // same color as border
          fontSize: 10,
        ),
      ),
    );
    add(_emptyText);

    final beefSprite = await game.loadSprite('food/beef_steak.png');
    setItemSprite(beefSprite);

    // Start hidden if the player isn't holding anything yet
    _itemSprite!.opacity = player.hasHeldItem ? 1.0 : 0.0;
  }

  /// Call this later when you know which image to show for the held item.
  void setItemSprite(Sprite sprite) {
    if (_itemSprite == null) {
      _itemSprite = SpriteComponent(
        sprite: sprite,
        size: size * 0.7, // a bit inset from the border
        anchor: Anchor.center,
        position: size / 2,
      );
      add(_itemSprite!);
    } else {
      _itemSprite!.sprite = sprite;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    final hasItem = player.hasHeldItem;

    // When the cook has something: hide text, show sprite (if any).
    // When inventory is empty: show "empty", hide sprite.
    _emptyText.text = hasItem ? '' : 'empty';
    if (_itemSprite != null) {
      _itemSprite!.opacity = hasItem ? 1.0 : 0.0;
    }
  }
}

import 'package:chaos_kitchen/game/cook_world.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ChaosKitchenGame extends FlameGame {
  ChaosKitchenGame() : super(world: CookWorld());

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;
  }

  @override
  void onMount() async {
    super.onMount();
    await Flame.device.fullScreen();
  }

  @override
  void onRemove() async {
    super.onRemove();
    await Flame.device.restoreFullscreen();
  }
}

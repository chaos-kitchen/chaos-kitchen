import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/objects/oven.dart';
import 'package:chaos_kitchen/game/objects/cutting_board.dart';
import 'package:chaos_kitchen/game/objects/sink.dart';
import 'package:chaos_kitchen/game/objects/appliances_shelf.dart';
import 'package:chaos_kitchen/game/objects/conveyor.dart';
import 'package:chaos_kitchen/game/objects/pantry.dart';
import 'package:chaos_kitchen/game/objects/fridge.dart';
import 'package:chaos_kitchen/game/objects/solid_object.dart';
import 'package:chaos_kitchen/game/viewport.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class CookWorld extends World
    with HasGameReference<ChaosKitchenGame>, TapCallbacks {
  @override
  Future<void> onLoad() async {
    final gameBounds = Vector2(32 * 30, 32 * 20);
    const scaleFactor = 1.6; // larger value = more zoomed in
    final background = SpriteComponent()
      ..sprite = await game.loadSprite('backgrounds/kitchen.png')
      ..size = gameBounds * scaleFactor
      ..anchor = Anchor.topLeft
      ..position = Vector2(-32 * 7.5, -32 * 5.5);
    add(background);

    final animation = SpriteAnimation.fromFrameData(
      await game.images.load('cook.png'),
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: Vector2.all(400),
        stepTime: 0.12,
      ),
    );
    final player = Player(
      position: Vector2(400.0, 400.0),
      animation: animation,
    );
    add(player);

    game.camera.viewport = PlayerViewport(player);
    game.camera.viewfinder.visibleGameSize = gameBounds;
    game.camera.viewfinder.position = gameBounds / 2;
    game.camera.viewfinder.anchor = Anchor.center;

    // add(
    //   OvenObject(
    //     position: Vector2(600, 300), // TODO: adjust to real oven location
    //     radius: 60,
    //   ),
    // );

    addAll([
      // four walls of the kitchen
      SolidObjectHitbox([
        Vector2(119.7, 90.7),
        Vector2(89.5, 605.0),
        Vector2(888.9, 611.0),
        Vector2(866.3, 89.5),
      ]),
      SolidObjectHitbox([
        Vector2(108.4, 340.7),
        Vector2(325.3, 339.0),
        Vector2(326.5, 304.6),
        Vector2(307.5, 300.4),
        Vector2(307.5, 315.9),
        Vector2(103.7, 318.8),
      ]),
      SolidObjectHitbox([
        Vector2(332.4, 90.7),
        Vector2(329.4, 228.1),
        Vector2(314.6, 218.1),
        Vector2(314.6, 89.5),
      ]),
      SolidObjectHitbox([
        Vector2(345.5, 173.0),
        Vector2(408.9, 163.0),
        Vector2(404.7, 117.9),
        Vector2(339.5, 125.6),
      ]),
      SolidObjectHitbox([
        Vector2(418.9, 160.0),
        Vector2(484.1, 161.8),
        Vector2(484.1, 116.7),
        Vector2(415.9, 102.5),
      ]),
      SolidObjectHitbox([
        Vector2(510.2, 92.5),
        Vector2(510.2, 165.9),
        Vector2(530.3, 232.3),
        Vector2(626.9, 232.3),
        Vector2(666.0, 171.9),
        Vector2(690.9, 125.6),
        Vector2(686.2, 90.7),
      ]),
      SolidObjectHitbox([
        Vector2(843.8, 90.7),
        Vector2(786.3, 119.7),
        Vector2(788.7, 183.1),
        Vector2(871.1, 197.3),
      ]),
      SolidObjectHitbox([
        Vector2(823.7, 244.2),
        Vector2(827.8, 372.1),
        Vector2(881.7, 376.9),
        Vector2(871.1, 241.2),
      ]),
      SolidObjectHitbox([
        Vector2(882.9, 506.7),
        Vector2(829.6, 505.5),
        Vector2(829.6, 571.8),
        Vector2(885.9, 573.0),
      ]),
      SolidObjectHitbox([
        Vector2(537.4, 344.9),
        Vector2(693.3, 341.9),
        Vector2(722.3, 368.0),
        Vector2(727.0, 442.1),
        Vector2(701.0, 479.4),
        Vector2(536.3, 477.6),
        Vector2(501.3, 444.4),
        Vector2(501.3, 375.1),
      ]),
      SolidObjectHitbox([
        Vector2(316.4, 606.2),
        Vector2(323.5, 466.4),
        Vector2(290.3, 454.5),
        Vector2(291.5, 608.0),
      ]),
      SolidObjectHitbox([
        Vector2(99.5, 459.3),
        Vector2(208.0, 467.6),
        Vector2(158.8, 495.4),
        Vector2(98.4, 496.6),
      ]),
      SolidObjectHitbox([
        Vector2(235.2, 564.7),
        Vector2(93.6, 560.0),
        Vector2(89.5, 595.0),
        Vector2(237.0, 593.2),
      ]),
    ]);

    add(OvenObject(position: Vector2(830, 276.7), radius: 32 * 1.5));

    add(CuttingBoardObject(position: Vector2(627.5, 479.4), radius: 32 * 1.5));

    add(SinkObject(position: Vector2(842.0, 539.3), size: Vector2(60, 70)));

    add(
      AppliancesShelfObject(
        position: Vector2(417.1, 157.6),
        size: Vector2(145, 50),
      ),
    );

    add(ConveyorObject(position: Vector2(800.5, 145.8), radius: 32 * 1.3));

    add(PantryObject(position: Vector2(157.0, 537.5), size: Vector2(120, 120)));

    add(FridgeObject(position: Vector2(122.0, 185.5), size: Vector2(40, 160)));
    add(FridgeObject(position: Vector2(241.1, 168.3), size: Vector2(130, 80)));
  }

  // TEMP: temporarily print tap positions for creating hitboxes
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    final position = event.localPosition;
    print(
      'Vector2(${position.x.toStringAsFixed(1)}, ${position.y.toStringAsFixed(1)}),',
    );
  }
}

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
    const scaleFactor = 1.0; // larger value = more zoomed in
    final background = SpriteComponent()
      ..sprite = await game.loadSprite('backgrounds/kitchen.png')
      ..size = gameBounds * scaleFactor
      ..anchor = Anchor.topLeft;
    add(background);

    final playerSprite = Sprite(await game.images.load('cook.png'));
    final player = Player(
      position: Vector2(400.0, 400.0),
      sprite: playerSprite,
    );
    add(player);

    final overlay = SpriteComponent()
      ..sprite = await game.loadSprite('backgrounds/kitchen_overlay.png')
      ..size = gameBounds * scaleFactor
      ..anchor = Anchor.topLeft
      ..priority = player.priority + 1;
    add(overlay);

    game.camera.viewport = PlayerViewport(player: player, showTimer: false);
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
      SolidObjectHitbox([
        // outer walls
        Vector2(47.4, 55.1),
        Vector2(953.4, 56.9),
        Vector2(951.7, 637.6),
        Vector2(0.6, 637.6),
        Vector2(0.6, 350.2),
        Vector2(40.9, 349.0),
      ]),
      SolidObjectHitbox([
        // fridge shelves and boxes
        Vector2(107.8, 213.9),
        Vector2(112.6, 117.3),
        Vector2(218.0, 114.4),
        Vector2(213.3, 90.7),
        Vector2(160.6, 84.7),
        Vector2(157.6, 56.9),
        Vector2(274.3, 56.9),
        Vector2(274.3, 209.2),
      ]),
      SolidObjectHitbox([
        // appliance shelf
        Vector2(285.0, 100.2),
        Vector2(294.5, 151.7),
        Vector2(379.8, 140.4),
        Vector2(468.7, 139.3),
        Vector2(477.6, 84.7),
        Vector2(375.1, 80.0),
      ]),
      SolidObjectHitbox([
        // ingredients express conveyor + boxes
        Vector2(499.5, 66.4),
        Vector2(502.5, 139.3),
        Vector2(524.4, 156.4),
        Vector2(526.2, 229.3),
        Vector2(653.6, 224.6),
        Vector2(664.2, 162.4),
        Vector2(699.8, 159.4),
        Vector2(699.8, 115.6),
        Vector2(734.2, 117.3),
        Vector2(731.2, 56.9),
      ]),
      SolidObjectHitbox([
        // final conveyor to other room
        Vector2(946.9, 67.6),
        Vector2(856.8, 90.7),
        Vector2(856.8, 162.4),
        Vector2(920.8, 177.8),
        Vector2(948.7, 179.6),
      ]),
      SolidObjectHitbox([
        // oven and stove
        Vector2(951.7, 235.3),
        Vector2(888.2, 235.3),
        Vector2(888.2, 387.6),
        Vector2(948.7, 390.5),
      ]),
      SolidObjectHitbox([
        // counter island
        Vector2(539.8, 350.2),
        Vector2(718.8, 350.2),
        Vector2(759.1, 390.5),
        Vector2(759.1, 454.5),
        Vector2(715.8, 499.6),
        Vector2(566.5, 499.6),
        Vector2(501.3, 457.5),
        Vector2(496.5, 401.8),
      ]),
      SolidObjectHitbox([
        // sink and garbage
        Vector2(946.9, 609.8),
        Vector2(888.2, 605.0),
        Vector2(889.4, 525.6),
        Vector2(916.1, 522.7),
        Vector2(916.1, 471.7),
        Vector2(946.9, 462.2),
      ]),
      SolidObjectHitbox([
        // fridge wall
        Vector2(42.6, 349.0),
        Vector2(279.1, 349.0),
        Vector2(279.1, 309.9),
        Vector2(263.1, 311.7),
        Vector2(264.9, 331.9),
        Vector2(39.7, 320.6),
      ]),
      SolidObjectHitbox([
        // pantry wall
        Vector2(2.4, 469.9),
        Vector2(162.3, 469.9),
        Vector2(165.3, 493.0),
        Vector2(126.2, 494.8),
        Vector2(125.0, 525.6),
        Vector2(8.3, 529.2),
      ]),
      SolidObjectHitbox([
        // pantry wall right
        Vector2(184.3, 592.6),
        Vector2(210.3, 591.4),
        Vector2(224.6, 525.6),
        Vector2(237.0, 493.0),
        Vector2(274.3, 480.6),
        Vector2(277.3, 558.8),
        Vector2(303.4, 570.7),
        Vector2(305.1, 600.3),
        Vector2(279.1, 614.5),
        Vector2(279.1, 631.7),
        Vector2(2.4, 634.6),
        Vector2(3.5, 589.6),
      ]),
    ]);

    children.whereType<SolidObjectHitbox>().forEach(
      (hb) => hb.priority = overlay.priority + 1,
    );

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

import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/objects/timer_object.dart';
import 'package:chaos_kitchen/game/viewport.dart';
import 'package:chaos_kitchen/game/objects/clipboard.dart';
import 'package:chaos_kitchen/game/objects/coal_pile.dart';
import 'package:chaos_kitchen/game/objects/computer.dart';
import 'package:chaos_kitchen/game/objects/conveyor_exit.dart';
import 'package:chaos_kitchen/game/objects/electrical_panel.dart';
import 'package:chaos_kitchen/game/objects/furnace.dart';
import 'package:chaos_kitchen/game/objects/water_pipes.dart';
import 'package:chaos_kitchen/game/objects/solid_object.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class InstructorWorld extends World
    with HasGameReference<ChaosKitchenGame>, TapCallbacks {
  final Vector2 initialPlayerPosition;
  final String? initialHeldItemId;
  final DateTime gameEndTime;
  InstructorWorld({
    required this.initialPlayerPosition,
    required this.initialHeldItemId,
    required this.gameEndTime,
  });

  @override
  Future<void> onLoad() async {
    final gameBounds = Vector2(32 * 30, 32 * 20);
    const scaleFactor = 1.0; // larger value = more zoomed in
    final background = SpriteComponent()
      ..sprite = await game.loadSprite('backgrounds/customer_area.png')
      ..size = gameBounds * scaleFactor
      ..anchor = Anchor.topLeft;
    add(background);

    final playerSprite = Sprite(await game.images.load('instructor.png'));
    final player = Player(
      position: initialPlayerPosition,
      heldItemId: initialHeldItemId,
      sprite: playerSprite,
    );
    add(player);

    final overlay = SpriteComponent()
      ..sprite = await game.loadSprite('backgrounds/customer_area_overlay.png')
      ..size = gameBounds * scaleFactor
      ..anchor = Anchor.topLeft
      ..priority = player.priority + 1;
    add(overlay);

    addAll([
      // Outer boundary walls
      SolidObjectHitbox([
        Vector2(180.7, 56.9),
        Vector2(95.4, 55.1),
        Vector2(95.4, 157.6),
        Vector2(34.9, 164.2),
        Vector2(30.2, 314.7),
        Vector2(107.8, 322.4),
        Vector2(106.0, 357.9),
        Vector2(0.6, 357.9),
        Vector2(-1.2, 637.6),
        Vector2(956.4, 639.4),
        Vector2(955.2, 616.3),
        Vector2(913.1, 605.0),
        Vector2(920.8, 580.1),
        Vector2(955.2, 570.7),
        Vector2(951.7, 84.7),
        Vector2(917.9, 87.7),
        Vector2(908.4, 55.1),
        Vector2(561.7, 53.9),
        Vector2(559.9, 157.6),
        Vector2(597.3, 167.1),
        Vector2(597.3, 187.3),
        Vector2(561.7, 182.5),
        Vector2(559.9, 229.3),
        Vector2(597.3, 232.3),
        Vector2(596.1, 259.0),
        Vector2(558.8, 257.2),
        Vector2(558.8, 302.2),
        Vector2(600.3, 302.2),
        Vector2(600.3, 330.1),
        Vector2(559.9, 330.1),
        Vector2(559.9, 379.8),
        Vector2(599.1, 389.3),
        Vector2(597.3, 409.5),
        Vector2(561.7, 407.7),
        Vector2(559.9, 490.1),
        Vector2(539.8, 513.2),
        Vector2(481.1, 507.2),
        Vector2(482.3, 485.3),
        Vector2(524.4, 468.1),
        Vector2(524.4, 104.9),
        Vector2(493.0, 89.5),
        Vector2(488.9, 56.9),
        Vector2(282.0, 53.9),
        Vector2(280.3, 128.0),
        Vector2(184.3, 125.0),
        Vector2(180.7, 56.9),
      ]),
      SolidObjectHitbox([
        Vector2(170.1, 355.0),
        Vector2(170.1, 334.8),
        Vector2(205.6, 337.8),
        Vector2(219.8, 359.7),
        Vector2(252.4, 362.7),
        Vector2(255.4, 517.9),
        Vector2(216.8, 521.5),
        Vector2(212.1, 575.4),
        Vector2(247.7, 586.7),
        Vector2(266.6, 634.6),
        Vector2(210.3, 639.4),
        Vector2(200.8, 361.5),
      ]),
      SolidObjectHitbox([
        Vector2(3.5, 517.9),
        Vector2(42.6, 525.6),
        Vector2(43.8, 562.9),
        Vector2(128.0, 564.7),
        Vector2(138.6, 535.1),
        Vector2(200.8, 529.2),
        Vector2(197.9, 637.6),
        Vector2(-1.2, 636.4),
      ]),
      SolidObjectHitbox([
        // Vector2(679.7, 554.1),
        Vector2(703.4, 535.1),
        Vector2(696.8, 516.7),
        Vector2(719.9, 464.0),
        Vector2(734.2, 464.0),
        Vector2(732.4, 434.4),
        Vector2(759.1, 435.5),
        Vector2(760.8, 462.2),
        Vector2(779.2, 462.2),
        Vector2(807.0, 512.0),
        Vector2(798.2, 529.2),
        Vector2(823.1, 547.5),
        Vector2(813.6, 574.2),
        Vector2(785.7, 562.9),
        Vector2(781.0, 566.5),
        Vector2(726.5, 564.7),
        Vector2(698.6, 578.9),
        Vector2(682.6, 562.9),
        Vector2(704.5, 538.1),
      ]),
      SolidObjectHitbox([
        Vector2(796.4, 376.9),
        Vector2(766.8, 375.1),
        Vector2(766.8, 345.5),
        Vector2(794.6, 347.3),
        Vector2(796.4, 327.1),
        Vector2(846.2, 300.4),
        Vector2(856.8, 305.2),
        Vector2(871.1, 289.8),
        Vector2(894.1, 302.2),
        Vector2(881.7, 322.4),
        Vector2(895.9, 334.8),
        Vector2(894.1, 382.8),
        Vector2(881.7, 401.8),
        Vector2(895.9, 429.6),
        Vector2(871.1, 443.8),
        Vector2(856.8, 412.4),
        Vector2(843.2, 414.2),
        Vector2(798.2, 384.6),
      ]),
      SolidObjectHitbox([
        Vector2(746.6, 277.3),
        Vector2(748.4, 241.8),
        Vector2(731.2, 238.2),
        Vector2(703.4, 190.2),
        Vector2(707.5, 177.8),
        Vector2(684.4, 164.2),
        Vector2(699.8, 137.5),
        Vector2(723.5, 147.0),
        Vector2(732.4, 137.5),
        Vector2(783.9, 137.5),
        Vector2(789.9, 151.7),
        Vector2(811.8, 140.4),
        Vector2(830.8, 167.1),
        Vector2(805.9, 181.3),
        Vector2(811.8, 190.2),
        Vector2(786.9, 237.0),
        Vector2(774.4, 240.0),
        Vector2(774.4, 271.4),
      ]),
    ]);

    children.whereType<SolidObjectHitbox>().forEach(
      (hb) => hb.priority = overlay.priority + 1,
    );

    add(ClipboardObject(position: Vector2(526.2, 404.7), radius: 32 * 1.5));
    add(CoalPileObject(position: Vector2(160.6, 546.4), radius: 32 * 1.2));
    add(ComputerObject(position: Vector2(230.5, 123.9), radius: 32 * 1.5));
    add(ConveyorExitObject(position: Vector2(85.9, 115.6), radius: 32 * 1.5));
    add(
      ElectricalPanelObject(position: Vector2(52.1, 352.0), radius: 32 * 1.5),
    );
    add(FurnaceObject(position: Vector2(33.2, 235.3), radius: 32 * 1.4));
    add(WaterPipesObject(position: Vector2(39.7, 533.9), radius: 32 * 1.2));

    add(
      PositionComponent(
        position: Vector2(107.8, 5.0),
        children: [TimerObject(gameEndTime: gameEndTime)],
      ),
    );

    game.camera.viewport = PlayerViewport(player: player);
    game.camera.viewfinder.visibleGameSize = gameBounds;
    game.camera.viewfinder.position = gameBounds / 2;
    game.camera.viewfinder.anchor = Anchor.center;
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

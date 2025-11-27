import 'package:chaos_kitchen/components/minigame_ui.dart';
import 'package:chaos_kitchen/game/actors/player.dart';
import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/ingredients.dart';
import 'package:chaos_kitchen/game/objects/furnace.dart';
import 'package:flutter/material.dart';

class FurnaceOverlayArgs {
  final Player player;
  final FurnaceObject furnace;

  FurnaceOverlayArgs({required this.player, required this.furnace});
}

class FurnaceOverlay extends StatefulWidget {
  final ChaosKitchenGame game;
  final FurnaceOverlayArgs args;

  FurnaceOverlay({super.key, required this.game})
    : args = game.overlayArgs as FurnaceOverlayArgs;

  @override
  State<FurnaceOverlay> createState() => _FurnaceOverlayState();
}

class _FurnaceOverlayState extends State<FurnaceOverlay> {
  @override
  Widget build(BuildContext context) {
    final furnaceItemNotifier = widget.args.furnace.heldItemNotifier;
    final playerHeldItemNotifier = widget.args.player.heldItemNotifier;

    return MinigameBackdrop(
      child: MinigameBox(
        children: [
          Align(
            alignment: const Alignment(-0.2, -0.6),
            child: SizedBox(
              // Set the box size to 50 so it can be aligned properly
              width: 50,
              height: 50,
              child: OverflowBox(
                maxHeight: 450,
                maxWidth: 450,
                child: Image.asset('assets/images/furnace.png'),
              ),
            ),
          ),

          MinigameCloseButton(onPressed: () => widget.game.closeFurnace()),

          Align(
            alignment: const Alignment(-0.13, -0.01),
            child: MinigameListenableItemSlot(
              itemIdNotifier: furnaceItemNotifier,
              onWillAccept: (payload) {
                // Only accept item if furnace slot is empty
                // and item is coal
                return furnaceItemNotifier.value == null &&
                    payload != null &&
                    payload.sourceSlot.itemId == IngredientIds.coal;
              },
            ),
          ),

          Align(
            alignment: const Alignment(0.9, 0.1),
            child: Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                MinigameListenableItemSlot(
                  itemIdNotifier: playerHeldItemNotifier,
                ),

                const Text(
                  'Inventory',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.brown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

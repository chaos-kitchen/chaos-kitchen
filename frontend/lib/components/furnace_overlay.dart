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
  String? furnaceSlotItemId;
  String? playerHeldItemId;

  @override
  void initState() {
    super.initState();
    setState(() {
      furnaceSlotItemId = widget.args.furnace.heldItemId;
      playerHeldItemId = widget.args.player.heldItemId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MinigameBackdrop(
      child: MinigameBox(
        children: [
          // Close button
          MinigameCloseButton(onPressed: () => widget.game.closeFurnace()),

          Align(
            alignment: const Alignment(0, -0.8),
            child: MinigameItemSlot(
              itemId: furnaceSlotItemId,
              onWillAccept: (payload) {
                // Only accept item if furnace slot is empty
                // and item is coal
                return furnaceSlotItemId == null &&
                    payload != null &&
                    payload.sourceSlot.itemId == IngredientIds.coal;
              },
              onItemChanged: (newItemId) {
                widget.args.furnace.heldItemId = newItemId;
                setState(() {
                  furnaceSlotItemId = newItemId;
                });
              },
            ),
          ),

          Align(
            alignment: const Alignment(0, 0.5),
            child: MinigameItemSlot(
              itemId: playerHeldItemId,
              onItemChanged: (newItemId) {
                widget.args.player.heldItemId = newItemId;
                setState(() {
                  playerHeldItemId = newItemId;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

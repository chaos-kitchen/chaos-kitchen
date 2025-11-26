import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/ingredients.dart';
import 'package:flutter/material.dart';

class DoughMixerOverlay extends StatefulWidget {
  final ChaosKitchenGame game;

  const DoughMixerOverlay({super.key, required this.game});

  @override
  State<DoughMixerOverlay> createState() => _DoughMixerOverlayState();
}

/// Payload for drag operations: which item, and where it came from.
/// sourceSlotIndex == null  -> came from inventory
/// sourceSlotIndex != null -> came from that slot index
class _DragPayload {
  final String itemId;
  final int? sourceSlotIndex;

  _DragPayload({required this.itemId, this.sourceSlotIndex});
}

enum MixingPhase { placeIngredients, mix }

class IngredientSlot {
  final Alignment alignment; // where slot appears around bowl
  String? itemId;

  IngredientSlot({required this.alignment, this.itemId});
}

class _DoughMixerOverlayState extends State<DoughMixerOverlay> {
  MixingPhase _phase = MixingPhase.placeIngredients;
  late List<IngredientSlot> _slots;

  @override
  void initState() {
    super.initState();

    final saved = widget.game.doughMixerSlots; // length 5

    _slots = [
      // Left column: top / middle / bottom
      IngredientSlot(alignment: const Alignment(-0.7, -0.6), itemId: saved[0]),
      IngredientSlot(alignment: const Alignment(-0.7, 0.0), itemId: saved[1]),
      IngredientSlot(alignment: const Alignment(-0.7, 0.6), itemId: saved[2]),

      // Right column: top / bottom
      IngredientSlot(alignment: const Alignment(0.7, -0.3), itemId: saved[3]),
      IngredientSlot(alignment: const Alignment(0.7, 0.3), itemId: saved[4]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // dark background over the game
        Positioned.fill(child: Container(color: Colors.black54)),

        // centered minigame panel
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 600,
              height: 350,
              color: const Color(0xFFF5E4C8),
              child: _buildPanelContents(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPanelContents() {
    return Stack(
      children: [
        // close button
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => widget.game.closeDoughMixer(),
            child: const Icon(Icons.close, size: 32, color: Colors.black87),
          ),
        ),

        // bowl in the middle
        Align(alignment: Alignment.center, child: _buildBowlArea()),

        // ingredient slots around the bowl
        ..._slots.asMap().entries.map(
          (entry) => _buildSlot(entry.key, entry.value),
        ),

        // inventory box inside overlay (bottom center)
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildInventoryBox(),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // INVENTORY BOX (overlay view of cook's held item)
  // ------------------------------------------------------------
  Widget _buildInventoryBox() {
    final player = widget.game.cookPlayer;
    final heldId = player?.heldItemId;
    final heldAsset = heldId != null ? ingredientAssetPaths[heldId] : null;

    return DragTarget<_DragPayload>(
      // Only accept drop from slots when inventory is empty
      onWillAccept: (payload) {
        if (player == null || payload == null) return false;
        // must have room in inventory
        return !player.hasHeldItem;
      },
      onAccept: (payload) {
        final p = widget.game.cookPlayer;
        if (p == null) return;

        final success = p.tryPickItem(payload.itemId);
        if (success && payload.sourceSlotIndex != null) {
          setState(() {
            final idx = payload.sourceSlotIndex!;
            _slots[idx].itemId = null;
            widget.game.doughMixerSlots[idx] = null;
          });
        }
      },
      builder: (context, candidate, rejected) {
        final borderColor = candidate.isNotEmpty
            ? Colors.greenAccent
            : Colors.brown[700]!;

        Widget inner;
        if (heldAsset != null) {
          // We have something in inventory: make it draggable out to slots
          inner = Draggable<_DragPayload>(
            data: _DragPayload(itemId: heldId!, sourceSlotIndex: null),
            feedback: Image.asset(
              'assets/images/$heldAsset',
              width: 60,
              height: 60,
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/$heldAsset',
                width: 60,
                height: 60,
              ),
            ),
            child: Image.asset(
              'assets/images/$heldAsset',
              width: 60,
              height: 60,
            ),
          );
        } else {
          // empty inventory
          inner = const SizedBox.shrink();
        }

        return Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: const Color(0xFFEEDFCC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 4),
          ),
          alignment: Alignment.center,
          child: inner,
        );
      },
    );
  }

  // ------------------------------------------------------------
  // SLOT WIDGETS — DragTarget + (optional) Draggable child
  // ------------------------------------------------------------
  Widget _buildSlot(int index, IngredientSlot slot) {
    final itemId = slot.itemId;
    final assetPath = itemId != null ? ingredientAssetPaths[itemId] : null;

    return Align(
      alignment: slot.alignment,
      child: DragTarget<_DragPayload>(
        onWillAccept: (payload) {
          // Only accept if slot empty and there is some payload
          return payload != null && slot.itemId == null;
        },
        onAccept: (payload) {
          final player = widget.game.cookPlayer;
          if (player == null) return;

          setState(() {
            if (payload.sourceSlotIndex == null) {
              // from inventory
              if (player.heldItemId == payload.itemId) {
                player.dropHeldItem();
              }
            } else {
              // from another slot
              final from = payload.sourceSlotIndex!;
              _slots[from].itemId = null;
              widget.game.doughMixerSlots[from] = null;
            }

            // place item into this slot
            slot.itemId = payload.itemId;
            widget.game.doughMixerSlots[index] = payload.itemId;
          });
        },
        builder: (context, candidate, rejected) {
          final borderColor = candidate.isNotEmpty
              ? Colors.greenAccent
              : Colors.brown[700]!;

          Widget child;
          if (assetPath == null) {
            // empty slot
            child = const SizedBox.shrink();
          } else {
            // slot has an item; make it draggable OUT (to other slots or inventory)
            child = Draggable<_DragPayload>(
              data: _DragPayload(itemId: itemId!, sourceSlotIndex: index),
              feedback: Image.asset(
                'assets/images/$assetPath',
                width: 60,
                height: 60,
              ),
              childWhenDragging: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/images/$assetPath',
                  width: 60,
                  height: 60,
                ),
              ),
              child: Image.asset(
                'assets/images/$assetPath',
                width: 60,
                height: 60,
              ),
            );
          }

          return Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFEEDFCC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: 4),
            ),
            alignment: Alignment.center,
            child: child,
          );
        },
      ),
    );
  }

  // ------------------------------------------------------------
  // BOWL AREA — we'll hook this up for the mixing phase later
  // ------------------------------------------------------------
  Widget _buildBowlArea() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFE7D3B5),
        border: Border.all(color: Colors.brown, width: 5),
      ),
      alignment: Alignment.center,
      child: _buildBowlInner(),
    );
  }

  Widget _buildBowlInner() {
    if (_phase == MixingPhase.mix) {
      return const Text(
        'Mix!',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      );
    }

    return const Text(
      'Bowl',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.brown,
        decoration: TextDecoration.underline,
      ),
    );
  }
}

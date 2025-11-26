import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/ingredients.dart';
import 'package:flutter/material.dart';

class DoughMixerOverlay extends StatefulWidget {
  final ChaosKitchenGame game;

  const DoughMixerOverlay({super.key, required this.game});

  @override
  State<DoughMixerOverlay> createState() => _DoughMixerOverlayState();
}

/// Drag payload: which item is being dragged, and from where.
/// sourceSlotIndex == null  => from inventory
/// sourceSlotIndex != null => from slot[index]
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

// The correct dough recipe (order doesn’t matter)
const Set<String> _correctDoughSet = {
  IngredientIds.flour,
  IngredientIds.butter,
  IngredientIds.salt,
  IngredientIds.water,
  IngredientIds.eggs,
};

class _DoughMixerOverlayState extends State<DoughMixerOverlay> {
  MixingPhase _phase = MixingPhase.placeIngredients;

  late List<IngredientSlot> _slots;

  // Whether we’ve checked the 5 ingredients yet
  bool _recipeEvaluated = false;
  bool _recipeCorrect = false;
  bool _ingredientsLocked = false; // true once the correct 5 are set
  int _ingredientsInBowl = 0; // how many have been dropped into bowl

  @override
  void initState() {
    super.initState();

    final saved =
        widget.game.doughMixerSlots; // length 5, lives in ChaosKitchenGame

    _slots = [
      // Left column: top / middle / bottom
      IngredientSlot(alignment: const Alignment(-0.7, -0.6), itemId: saved[0]),
      IngredientSlot(alignment: const Alignment(-0.7, 0.0), itemId: saved[1]),
      IngredientSlot(alignment: const Alignment(-0.7, 0.6), itemId: saved[2]),

      // Right column: top / bottom
      IngredientSlot(alignment: const Alignment(0.7, -0.3), itemId: saved[3]),
      IngredientSlot(alignment: const Alignment(0.7, 0.3), itemId: saved[4]),
    ];

    _recalculateRecipeState(); // in case slots were already filled
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dim the game behind
        Positioned.fill(child: Container(color: Colors.black54)),

        // Centered minigame panel
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
        // Close button
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => widget.game.closeDoughMixer(),
            child: const Icon(Icons.close, size: 32, color: Colors.black87),
          ),
        ),

        // Bowl (graphics + label) in the middle
        Align(alignment: Alignment.center, child: _buildBowlArea()),

        // Ingredient slots around the bowl
        ..._slots.asMap().entries.map(
          (entry) => _buildSlot(entry.key, entry.value),
        ),

        // Overlay inventory box (bottom center)
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

  // ---------------------------------------------------------------------------
  // Inventory box inside overlay (mirror of cook's held item)
  // ---------------------------------------------------------------------------
  Widget _buildInventoryBox() {
    final player = widget.game.cookPlayer;
    final heldId = player?.heldItemId;
    final heldAsset = heldId != null ? ingredientAssetPaths[heldId] : null;

    return DragTarget<_DragPayload>(
      // Only accept drops from slots when inventory is empty and NOT locked
      onWillAccept: (payload) {
        if (player == null || payload == null) return false;
        if (_ingredientsLocked) return false;
        return !player.hasHeldItem;
      },
      onAccept: (payload) {
        final p = widget.game.cookPlayer;
        if (p == null) return;

        setState(() {
          final success = p.tryPickItem(payload.itemId);
          if (success && payload.sourceSlotIndex != null) {
            final idx = payload.sourceSlotIndex!;
            _slots[idx].itemId = null;
            widget.game.doughMixerSlots[idx] = null;
          }
          _recalculateRecipeState();
        });
      },
      builder: (context, candidate, rejected) {
        final borderColor = candidate.isNotEmpty
            ? Colors.greenAccent
            : Colors.brown[700]!;

        Widget inner;
        if (heldAsset != null) {
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

  // ---------------------------------------------------------------------------
  // Slots: DragTargets that can hold an item and be dragged out again
  // ---------------------------------------------------------------------------
  Widget _buildSlot(int index, IngredientSlot slot) {
    final itemId = slot.itemId;
    final assetPath = itemId != null ? ingredientAssetPaths[itemId] : null;

    return Align(
      alignment: slot.alignment,
      child: DragTarget<_DragPayload>(
        onWillAccept: (payload) {
          // Only accept if slot is empty AND we’re not locked in
          if (_ingredientsLocked) return false;
          return payload != null && slot.itemId == null;
        },
        onAccept: (payload) {
          final player = widget.game.cookPlayer;
          if (player == null) return;

          setState(() {
            if (payload.sourceSlotIndex == null) {
              // From inventory
              if (player.heldItemId == payload.itemId) {
                player.dropHeldItem();
              }
            } else {
              // From another slot
              final from = payload.sourceSlotIndex!;
              _slots[from].itemId = null;
              widget.game.doughMixerSlots[from] = null;
            }

            slot.itemId = payload.itemId;
            widget.game.doughMixerSlots[index] = payload.itemId;

            _recalculateRecipeState();
          });
        },
        builder: (context, candidate, rejected) {
          final bool isHovering = candidate.isNotEmpty;

          Color bgColor = const Color(0xFFEEDFCC);

          if (slot.itemId != null && _recipeEvaluated && _recipeCorrect) {
            // Correct recipe and this slot still has an ingredient → green
            bgColor = const Color(0xFFD6F5D6);
          } else if (slot.itemId != null &&
              _recipeEvaluated &&
              !_recipeCorrect) {
            // Wrong combination → red
            bgColor = const Color(0xFFF8D6D6);
          }

          final borderColor = isHovering
              ? Colors.greenAccent
              : Colors.brown[700]!;

          Widget child;
          if (assetPath == null) {
            child = const SizedBox.shrink();
          } else {
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
              color: bgColor,
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

  // ---------------------------------------------------------------------------
  // Bowl area: use your bowl + spoon assets, with text overlay
  // ---------------------------------------------------------------------------
  Widget _buildBowlArea() {
    return DragTarget<_DragPayload>(
      // Only accept ingredients from slots when we’re locked in (correct recipe)
      onWillAccept: (payload) {
        if (!_ingredientsLocked) return false;
        if (payload == null) return false;
        // Only allow dragging from slots, not from inventory
        return payload.sourceSlotIndex != null;
      },
      onAccept: (payload) {
        final idx = payload.sourceSlotIndex;
        if (idx == null) return;

        setState(() {
          // “Consume” ingredient from that slot
          _slots[idx].itemId = null;
          widget.game.doughMixerSlots[idx] = null;
          _ingredientsInBowl++;

          // If all 5 ingredients have been added to the bowl, reset everything
          if (_ingredientsInBowl >= 5) {
            _resetSlotsState();
          }
        });
      },
      builder: (context, candidate, rejected) {
        final bool isHovering = candidate.isNotEmpty;

        return SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Optional glow when hovering with an ingredient
              if (isHovering)
                Container(
                  width: 190,
                  height: 190,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x33FFFFFF),
                  ),
                ),

              // Bowl sprite
              Image.asset(
                'assets/images/mix_bowl_empty.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),

              // Spoon ABOVE the bowl (slightly overlapping at most)
              Positioned(
                top: 10, // adjust to taste
                child: Image.asset(
                  'assets/images/mix_spoon.png',
                  width: 140,
                  fit: BoxFit.contain,
                ),
              ),

              // Label text ("Bowl" or "Mix")
              _buildBowlLabel(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBowlLabel() {
    final label = (_phase == MixingPhase.mix && _recipeCorrect)
        ? 'Mix'
        : 'Bowl';

    return Text(
      label,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.brown,
        decoration: TextDecoration.underline,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Recipe evaluation: called whenever slots change
  // ---------------------------------------------------------------------------
  void _recalculateRecipeState() {
    final allFilled = _slots.every((s) => s.itemId != null);

    if (!allFilled) {
      // Not all slots filled → everything is “free” again
      _recipeEvaluated = false;
      _recipeCorrect = false;
      _ingredientsLocked = false;
      _ingredientsInBowl = 0;
      _phase = MixingPhase.placeIngredients;
      return;
    }

    // Compare as sets so order doesn’t matter
    final items = _slots.map((s) => s.itemId!).toSet();
    final correct =
        items.length == _correctDoughSet.length &&
        items.containsAll(_correctDoughSet);

    _recipeEvaluated = true;
    _recipeCorrect = correct;

    if (correct) {
      _ingredientsLocked = true; // lock slots in
      _ingredientsInBowl = 0; // not started mixing yet
      _phase = MixingPhase.mix;
    } else {
      _ingredientsLocked = false; // still adjustable
      _ingredientsInBowl = 0;
      _phase = MixingPhase.placeIngredients;
    }
  }

  void _resetSlotsState() {
    // Clear all slots & game state
    for (var i = 0; i < _slots.length; i++) {
      _slots[i].itemId = null;
      widget.game.doughMixerSlots[i] = null;
    }

    _recipeEvaluated = false;
    _recipeCorrect = false;
    _ingredientsLocked = false;
    _ingredientsInBowl = 0;
    _phase = MixingPhase.placeIngredients;
  }
}

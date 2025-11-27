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

class IngredientSlot {
  final Alignment alignment; // where slot appears around bowl
  String? itemId;

  IngredientSlot({required this.alignment, this.itemId});
}

// The required 5 ingredients (order in slots doesn’t matter)
const Set<String> _correctDoughSet = {
  IngredientIds.flour,
  IngredientIds.butter,
  IngredientIds.salt,
  IngredientIds.water,
  IngredientIds.eggs,
};

class _DoughMixerOverlayState extends State<DoughMixerOverlay> {
  late List<IngredientSlot> _slots;

  // Slot / recipe state
  bool _recipeEvaluated = false;
  bool _recipeCorrect = false;
  bool _ingredientsLocked = false; // once correct 5 slots are set

  // Bowl sequence state
  // 0: waiting water
  // 1: waiting flour
  // 2: waiting eggs
  // 3: waiting mix #1 (2 sec)
  // 4: waiting salt
  // 5: waiting butter
  // 6: waiting mix #2 (2 sec)
  // 7: finished
  int _sequenceStep = 0;
  bool _sequenceFailed = false;

  // Bowl sprite path
  String _bowlSprite = 'assets/images/mix_bowl_empty.png';

  // Mixing gesture timing
  DateTime? _mixStartTime;
  bool _mixCompletedForCurrentStep = false;

  bool _isHoldingSpoon = false;

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

    _recalculateRecipeState();

    // Ensure bowl starts in a clean state when opening overlay
    _sequenceStep = 0;
    _sequenceFailed = false;
    _bowlSprite = 'assets/images/mix_bowl_empty.png';
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

  Widget _buildSideSpoon() {
    // Show spoon only during mixing phases
    final bool showSpoon =
        _ingredientsLocked && (_sequenceStep == 3 || _sequenceStep == 6);

    if (!showSpoon) {
      return const SizedBox.shrink();
    }

    return Align(
      // Shift spoon further right (tweak 0.65–0.7 to taste)
      alignment: const Alignment(0.4, 0.0),
      child: Draggable<String>(
        data: 'spoon', // dummy payload

        onDragStarted: () {
          // Start timing the mix
          _mixStartTime = DateTime.now();
          _mixCompletedForCurrentStep = false;
        },

        onDragEnd: (_) {
          if (_mixStartTime == null || _mixCompletedForCurrentStep) return;

          final elapsed =
              DateTime.now().difference(_mixStartTime!).inMilliseconds / 1000.0;

          _mixStartTime = null;

          if (elapsed >= 2.0) {
            _mixCompletedForCurrentStep = true;
            _completeMixStep();
          }
        },

        feedback: Image.asset(
          'assets/images/mix_spoon.png',
          width: 120,
          fit: BoxFit.contain,
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: Image.asset(
            'assets/images/mix_spoon.png',
            width: 120,
            fit: BoxFit.contain,
          ),
        ),
        child: Image.asset(
          'assets/images/mix_spoon.png',
          width: 120,
          fit: BoxFit.contain,
        ),
      ),
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
        Align(alignment: const Alignment(0, -0.55), child: _buildBowlArea()),

        // Ingredient slots around the bowl
        ..._slots.asMap().entries.map(
          (entry) => _buildSlot(entry.key, entry.value),
        ),

        // Side spoon (only visible during mixing phases)
        _buildSideSpoon(),

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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Inventory',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 4),

        // The existing DragTarget box
        DragTarget<_DragPayload>(
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
        ),
      ],
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

          // Base background color
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
  // Bowl area: DragTarget + GestureDetector for mixing
  // ---------------------------------------------------------------------------
  Widget _buildBowlArea() {
    return DragTarget<_DragPayload>(
      onWillAccept: (payload) {
        if (!_ingredientsLocked) return false;
        if (payload == null) return false;
        if (payload.sourceSlotIndex == null)
          return false; // must come from slot
        if (_sequenceStep == 3 || _sequenceStep == 6)
          return false; // mixing step
        if (_sequenceStep >= 7) return false;
        return true;
      },
      onAccept: (payload) {
        final idx = payload.sourceSlotIndex;
        if (idx == null) return;

        setState(() {
          _handleIngredientIntoBowl(payload.itemId, idx);
        });
      },
      builder: (context, candidate, rejected) {
        final bool isHovering = candidate.isNotEmpty;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Label above bowl
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: _buildBowlLabel(),
            ),
            SizedBox(
              width: 200,
              height: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (isHovering)
                    Container(
                      width: 190,
                      height: 190,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0x33FFFFFF),
                      ),
                    ),

                  Image.asset(
                    _bowlSprite,
                    width: 180,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBowlLabel() {
    String text = "Bowl";
    Color color = Colors.brown;

    // 1) After 5 slots are filled → recipe evaluated
    if (_recipeEvaluated) {
      if (_recipeCorrect) {
        // Correct 5 ingredients placed in boxes
        if (_sequenceStep < 7) {
          // Still performing the mixing sequence
          if (_sequenceStep == 3 || _sequenceStep == 6) {
            text = "Mix";
          } else {
            text = "Add Ingredients";
          }
        } else {
          // Finished mixing sequence
          if (_sequenceFailed) {
            text = "Failed";
            color = Colors.red[700]!;
          } else {
            text = "Complete";
            color = Colors.green[700]!;
          }
        }
      } else {
        // Wrong 5 ingredients in slots
        if (_sequenceStep >= 7) {
          // Even if they finished mixing with wrong steps
          text = "Failed";
          color = Colors.red[700]!;
        } else {
          text = "Try Again";
          color = Colors.red[700]!;
        }
      }
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
        decoration: TextDecoration.underline,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Recipe evaluation for the slots (before any mixing)
  // ---------------------------------------------------------------------------
  void _recalculateRecipeState() {
    final allFilled = _slots.every((s) => s.itemId != null);

    if (!allFilled) {
      // Not all slots filled → everything is “free” again
      _recipeEvaluated = false;
      _recipeCorrect = false;
      _ingredientsLocked = false;
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
      _ingredientsLocked = true; // lock slots in; now we mix into bowl
      _sequenceStep = 0;
      _sequenceFailed = false;
      _bowlSprite = 'assets/images/mix_bowl_empty.png';
    } else {
      _ingredientsLocked = false;
      _sequenceStep = 0;
      _sequenceFailed = true; // already “bad” if they continue
      _bowlSprite = 'assets/images/mix_bowl_empty.png';
    }
  }

  // ---------------------------------------------------------------------------
  // Handle ingredient dropping from slot into bowl (sequence logic)
  // ---------------------------------------------------------------------------
  void _handleIngredientIntoBowl(String itemId, int slotIndex) {
    // Clear that slot visually & in game state
    _slots[slotIndex].itemId = null;
    widget.game.doughMixerSlots[slotIndex] = null;

    // 1) Choose bowl sprite based on the actual ingredient that was dropped.
    String? sprite;
    if (itemId == IngredientIds.water) {
      sprite = 'assets/images/mix_bowl_water.png';
    } else if (itemId == IngredientIds.eggs) {
      sprite = 'assets/images/mix_bowl_eggs.png';
    } else if (itemId == IngredientIds.butter) {
      sprite = 'assets/images/mix_bowl_butter.png';
    } else if (itemId == IngredientIds.flour || itemId == IngredientIds.salt) {
      // both flour and salt look like powder in the bowl
      sprite = 'assets/images/mix_bowl_powder.png';
    }

    // 2) Update correctness / sequence state based on *expected* ingredient.
    switch (_sequenceStep) {
      case 0: // expect water
        if (itemId != IngredientIds.water) {
          _sequenceFailed = true;
        }
        _sequenceStep = 1;
        break;

      case 1: // expect flour
        if (itemId != IngredientIds.flour) {
          _sequenceFailed = true;
        }
        _sequenceStep = 2;
        break;

      case 2: // expect eggs
        if (itemId != IngredientIds.eggs) {
          _sequenceFailed = true;
        }
        _sequenceStep = 3; // now wait for first mixing
        break;

      case 4: // expect salt
        if (itemId != IngredientIds.salt) {
          _sequenceFailed = true;
        }
        _sequenceStep = 5;
        break;

      case 5: // expect butter
        if (itemId != IngredientIds.butter) {
          _sequenceFailed = true;
        }
        _sequenceStep = 6; // now wait for second mixing
        break;

      default:
        // Ingredient dropped at an unexpected time
        _sequenceFailed = true;
        break;
    }

    // 3) Finally, apply the chosen sprite (if we recognized the ingredient).
    if (sprite != null) {
      _bowlSprite = sprite;
    }
  }

  // ---------------------------------------------------------------------------
  // Mixing gesture handlers (2 seconds of stirring)
  // ---------------------------------------------------------------------------
  void _onMixStart(DragStartDetails details) {
    if (!_ingredientsLocked) return;
    if (!(_sequenceStep == 3 || _sequenceStep == 6)) return;

    if (!_isHoldingSpoon) return;

    _mixStartTime = DateTime.now();
    _mixCompletedForCurrentStep = false;
  }

  void _onMixUpdate(DragUpdateDetails details) {
    if (_mixStartTime == null) return;
    if (_mixCompletedForCurrentStep) return;

    final elapsed =
        DateTime.now().difference(_mixStartTime!).inMilliseconds / 1000.0;

    if (elapsed >= 2.0) {
      _mixCompletedForCurrentStep = true;
      _completeMixStep();
    }
  }

  void _onMixEnd(DragEndDetails details) {
    _mixStartTime = null;
  }

  void _completeMixStep() {
    setState(() {
      if (_sequenceStep == 3) {
        // First mixing done → intermediate dough
        _bowlSprite = 'assets/images/mix_bowl_dough_intermediate.png';
        _sequenceStep = 4; // now expecting salt
      } else if (_sequenceStep == 6) {
        // Second mixing done → final dough (good or bad)
        _sequenceStep = 7;

        final player = widget.game.cookPlayer;

        // Decide if this run was successful:
        // - recipe had the correct 5 ingredients
        // - and sequence didn’t get marked as failed by wrong order
        final bool success = _recipeCorrect && !_sequenceFailed;

        if (success) {          
          _bowlSprite = 'assets/images/mix_bowl_dough_done.png';

          if (player != null) {
            // If they’re holding something, drop it first (one-slot inventory)
            if (player.hasHeldItem) {
              player.dropHeldItem();
            }
            // Add good dough to inventory
            player.tryPickItem('dough'); // ID for food/dough.png
          }
        } else {          
          _bowlSprite = 'assets/images/mix_bowl_dough_bad.png';

          if (player != null) {
            if (player.hasHeldItem) {
              player.dropHeldItem();
            }
            // Add bad dough to inventory
            player.tryPickItem('dough_bad'); // ID for food/dough_bad.png
          }
        }
      }
    });
  }
}

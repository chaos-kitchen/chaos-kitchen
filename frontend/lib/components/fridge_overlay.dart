import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/ingredients.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // for kDebugMode + debugPrint

class FridgeOverlay extends StatefulWidget {
  final ChaosKitchenGame game;

  const FridgeOverlay({super.key, required this.game});

  @override
  State<FridgeOverlay> createState() => _FridgeOverlayState();
}

class _FridgeOverlayState extends State<FridgeOverlay> {
  // Base size for fridge ingredient icons
  static const double _baseIngredientSize = 58.0;

  // Per-ingredient scale overrides: 1.0 = normal, >1 = bigger, <1 = smaller.
  static const Map<String, double> _ingredientSizeScale = {
    // tweak these however you like:
    IngredientIds.eggs: 1.6,
    IngredientIds.butter: 1.2,
    IngredientIds.mushrooms: 1.2,
    IngredientIds.beefFillet: 1.1,
    IngredientIds.prosciutto: 1.6,
  };

  void _handleItemDropped(String itemId) {
    final player = widget.game.cookPlayer;
    if (player == null) return;

    final picked = player.tryPickItem(itemId);
    if (!picked) {
      // inventory already full, do nothing for now
      return;
    }

    setState(() {
      // just trigger rebuild; heldItemId will be read from player
    });
  }

  void _handleInventoryTap() {
    final player = widget.game.cookPlayer;
    if (player == null) return;

    if (player.heldItemId != null) {
      player.dropHeldItem();
      setState(() {
        // rebuild, now heldItemId will be null
      });
    }
  }

  /// Helper to place a draggable ingredient sprite at a given position.
  Widget _ingredientDraggable({
    required String ingredientId,
    required double left,
    required double top,
  }) {
    final asset = ingredientAssetPaths[ingredientId]!;

    // Look up per-ingredient scale (default 1.0)
    final scale = _ingredientSizeScale[ingredientId] ?? 1.0;
    final size = _baseIngredientSize * scale;

    return Positioned(
      left: left,
      top: top,
      child: Draggable<String>(
        data: ingredientId,
        feedback: Image.asset(
          'assets/images/$asset',
          width: size,
          height: size,
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: Image.asset('assets/images/$asset', width: size, height: size),
        ),
        child: Image.asset('assets/images/$asset', width: size, height: size),
      ),
    );
  }

  Widget _doughStoragePlaceholder({required double left, required double top}) {
    return Positioned(
      left: left,
      top: top,
      child: DragTarget<String>(
        // Only accept good dough
        onWillAccept: (data) => data == IngredientIds.dough,
        onAccept: (data) {
          final player = widget.game.cookPlayer;
          if (player == null) return;

          // Only store if the player is actually holding dough
          if (player.heldItemId == IngredientIds.dough) {
            player.dropHeldItem();
          }

          setState(() {
            widget.game.hasDoughStored = true;
          });
        },
        builder: (context, candidate, rejected) {
          final isActive = candidate.isNotEmpty;
          final borderColor = isActive
              ? Colors.greenAccent
              : Colors.white.withOpacity(0.7);

          return Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor, width: 3),
            ),
            alignment: Alignment.center,
            child: Text(
              '?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: borderColor,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final heldItemId = widget.game.cookPlayer?.heldItemId;

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: (TapDownDetails details) {
            final renderBox = context.findRenderObject() as RenderBox;
            final localPos = renderBox.globalToLocal(details.globalPosition);

            if (kDebugMode) {
              debugPrint(
                'Fridge tap at: x= ${localPos.dx.toStringAsFixed(1)}, '
                'y= ${localPos.dy.toStringAsFixed(1)}',
              );
            }
          },
          child: Stack(
            children: [
              // Background fridge art
              Positioned.fill(
                child: Image.asset(
                  'assets/images/backgrounds/fridge.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Close / back button
              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      widget.game.closeFridge();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/cross_small.png',
                        width: 32,
                        height: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // === Cold ingredients on the shelves ===
              // tweak positions to line up with your fridge shelves
              _ingredientDraggable(
                ingredientId: IngredientIds.butter,
                left: 155.0,
                top: 224.1,
              ),
              _ingredientDraggable(
                ingredientId: IngredientIds.mushrooms,
                left: 270.5,
                top: 218.4,
              ),
              _ingredientDraggable(
                ingredientId: IngredientIds.beefFillet,
                left: 460.5,
                top: 106.0,
              ),
              _ingredientDraggable(
                ingredientId: IngredientIds.prosciutto,
                left: 453.5,
                top: 300.0,
              ),
              _ingredientDraggable(
                ingredientId: IngredientIds.eggs,
                left: 254.3,
                top: 101.7,
              ),
              _ingredientDraggable(
                ingredientId: IngredientIds.water,
                left: 152.7,
                top: 115.5,
              ),

              // === Dough storage slot (unlockable) ===
              widget.game.hasDoughStored
                  ? _ingredientDraggable(
                      ingredientId: IngredientIds.dough,
                      left: 460,
                      top: 215,
                    )
                  : _doughStoragePlaceholder(left: 460, top: 215),

              // === Inventory slot (drag target + tap to discard) ===
              Positioned(
                right: 32,
                bottom: 32,
                child: _InventoryDragTarget(
                  heldItemId: heldItemId,
                  onItemDropped: _handleItemDropped,
                  onTap: _handleInventoryTap,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InventoryDragTarget extends StatelessWidget {
  final String? heldItemId;
  final void Function(String itemId) onItemDropped;
  final VoidCallback onTap;

  const _InventoryDragTarget({
    required this.heldItemId,
    required this.onItemDropped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // tap to discard
      child: DragTarget<String>(
        // Accept any recognized ingredient ID
        onWillAccept: (data) =>
            data != null && ingredientAssetPaths.containsKey(data),
        onAccept: onItemDropped,
        builder: (context, candidate, rejected) {
          final isActive = candidate.isNotEmpty;
          final borderColor = Colors.white.withOpacity(isActive ? 0.9 : 0.5);

          return Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 3),
            ),
            alignment: Alignment.center,
            child: heldItemId == null
                ? Text(
                    'empty',
                    style: TextStyle(
                      color: borderColor,
                      fontSize: 12,
                      decoration: TextDecoration.none,
                    ),
                  )
                : Draggable<String>(
                    data: heldItemId!, // e.g. IngredientIds.dough
                    feedback: Image.asset(
                      'assets/images/${ingredientAssetPaths[heldItemId]!}',
                      width: 50,
                      height: 50,
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        'assets/images/${ingredientAssetPaths[heldItemId]!}',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/${ingredientAssetPaths[heldItemId]!}',
                      width: 50,
                      height: 50,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

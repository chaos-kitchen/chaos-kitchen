// import 'package:chaos_kitchen/game/game.dart';
// import 'package:flutter/material.dart';

// class PantryOverlay extends StatelessWidget {
//   final ChaosKitchenGame game;

//   const PantryOverlay({super.key, required this.game});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Background pantry art
//         Positioned.fill(
//           child: Image.asset(
//             'assets/images/backgrounds/pantry.png',
//             fit: BoxFit.cover,
//           ),
//         ),

//         // Back arrow
//         SafeArea(
//           child: Align(
//             alignment: Alignment.topLeft,
//             child: GestureDetector(
//               onTap: () {
//                 game.closePantry();
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0), // bigger touch area
//                 child: Image.asset(
//                   'assets/images/cross_small.png',
//                   width: 40,
//                   height: 40,
//                   // color: Colors.white, // optional tint
//                 ),
//               ),
//             ),
//           ),
//         ),

//         // TODO: ingredient hotspots / buttons go here later
//       ],
//     );
//   }
// }

import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/ingredients.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // for kDebugMode + debugPrint

class PantryOverlay extends StatefulWidget {
  final ChaosKitchenGame game;

  const PantryOverlay({super.key, required this.game});

  @override
  State<PantryOverlay> createState() => _PantryOverlayState();
}

class _PantryOverlayState extends State<PantryOverlay> {
  // Base size for fridge ingredient icons
  static const double _baseIngredientSize = 58.0;

  // Per-ingredient scale overrides: 1.0 = normal, >1 = bigger, <1 = smaller.
  static const Map<String, double> _ingredientSizeScale = {
    // tweak these however you like:
    IngredientIds.flour: 1.3,
    IngredientIds.salt: 1.1,
    IngredientIds.pepper: 1.2,
    IngredientIds.garlic: 1.2,
    IngredientIds.onionWhite: 1.2,
    IngredientIds.thyme: 1.2,
  };

  void _handleItemDropped(String itemId) {
    final player = widget.game.cookPlayer;
    if (player == null) return;

    final picked = player.tryPickItem(itemId);
    if (!picked) {
      // inventory already full
      return;
    }

    setState(() {
      // heldItemId now updated on the player
    });
  }

  void _handleInventoryTap() {
    final player = widget.game.cookPlayer;
    if (player == null) return;

    if (player.heldItemId != null) {
      player.dropHeldItem();
      setState(() {});
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
                'Pantry tap at: x= ${localPos.dx.toStringAsFixed(1)}, '
                'y= ${localPos.dy.toStringAsFixed(1)}',
              );
            }
          },
          child: Stack(
            children: [
              // Background pantry art
              Positioned.fill(
                child: Image.asset(
                  'assets/images/backgrounds/pantry.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Close / back button
              SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      widget.game.closePantry();
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

              // === Pantry ingredients on shelves ===
              // Tweak the positions to line up with your painted shelves
              _ingredientDraggable(
                ingredientId: IngredientIds.flour,
                left: 205.7,
                top: 102.7,
              ),
              _ingredientDraggable(
                ingredientId: IngredientIds.salt,
                left: 353.5,
                top: 106.6,
              ),
              _ingredientDraggable(
                ingredientId: IngredientIds.pepper,
                left: 542.1,
                top: 96.5,
              ),
              _ingredientDraggable(
                ingredientId: IngredientIds.onionWhite,
                left: 665.5,
                top: 97.0,
              ),
              _ingredientDraggable(
                ingredientId: IngredientIds.garlic,
                left: 210.4,
                top: 202.8,
              ),
              _ingredientDraggable(
                ingredientId: IngredientIds.thyme,
                left: 351.1,
                top: 207.9,
              ),

              // === Inventory box (same look/behaviour as fridge) ===
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
      onTap: onTap,
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
                : Image.asset(
                    'assets/images/${ingredientAssetPaths[heldItemId]!}',
                    width: 70,
                    height: 70,
                  ),
          );
        },
      ),
    );
  }
}

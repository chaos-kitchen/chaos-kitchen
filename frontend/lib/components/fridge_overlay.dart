// import 'package:chaos_kitchen/game/game.dart';
// import 'package:flutter/material.dart';

// class FridgeOverlay extends StatelessWidget {
//   final ChaosKitchenGame game;

//   const FridgeOverlay({super.key, required this.game});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Background fridge art
//         Positioned.fill(
//           child: Image.asset(
//             'assets/images/backgrounds/fridge.png',
//             fit: BoxFit.cover,
//           ),
//         ),

//         // Back arrow
//         SafeArea(
//           child: Align(
//             alignment: Alignment.topLeft,
//             child: GestureDetector(
//               onTap: () {
//                 game.closeFridge();
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0), // bigger touch area
//                 child: Image.asset(
//                   'assets/images/cross_small.png',
//                   width: 40,
//                   height: 40,
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
import 'package:flutter/material.dart';

class FridgeOverlay extends StatefulWidget {
  final ChaosKitchenGame game;

  const FridgeOverlay({super.key, required this.game});

  @override
  State<FridgeOverlay> createState() => _FridgeOverlayState();
}

class _FridgeOverlayState extends State<FridgeOverlay> {
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

  @override
  Widget build(BuildContext context) {
    final heldItemId = widget.game.cookPlayer?.heldItemId;

    return Stack(
      children: [
        // Background fridge art
        Positioned.fill(
          child: Image.asset(
            'assets/images/backgrounds/fridge.png',
            fit: BoxFit.cover,
          ),
        ),

        // Back arrow
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

        // === Draggable beef on the shelf ===
        Positioned(
          left: 180, // tweak to line up with shelf
          top: 200, // tweak to line up with shelf
          child: Draggable<String>(
            data: 'beef_steak',
            feedback: Image.asset(
              'assets/images/food/beef_steak.png',
              width: 48,
              height: 48,
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/food/beef_steak.png',
                width: 48,
                height: 48,
              ),
            ),
            child: Image.asset(
              'assets/images/food/beef_steak.png',
              width: 48,
              height: 48,
            ),
          ),
        ),

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
        onWillAccept: (data) => data == 'beef_steak',
        onAccept: onItemDropped,
        builder: (context, candidate, rejected) {
          final isActive = candidate.isNotEmpty;
          final borderColor = Colors.white.withOpacity(isActive ? 0.9 : 0.5);

          return Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 3),
            ),
            alignment: Alignment.center,
            child: heldItemId == null
                ? Text(
                    'empty',
                    style: TextStyle(color: borderColor, fontSize: 10),
                  )
                : Image.asset(
                    'assets/images/food/beef_steak.png',
                    width: 40,
                    height: 40,
                  ),
          );
        },
      ),
    );
  }
}

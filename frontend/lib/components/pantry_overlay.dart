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
import 'package:flutter/material.dart';

class PantryOverlay extends StatefulWidget {
  final ChaosKitchenGame game;

  const PantryOverlay({super.key, required this.game});

  @override
  State<PantryOverlay> createState() => _PantryOverlayState();
}

class _PantryOverlayState extends State<PantryOverlay> {
  void _handleInventoryTap() {
    final player = widget.game.cookPlayer;
    if (player == null) return;

    if (player.heldItemId != null) {
      player.dropHeldItem();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final heldItemId = widget.game.cookPlayer?.heldItemId;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/backgrounds/pantry.png',
            fit: BoxFit.cover,
          ),
        ),

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

        // Inventory box (same look as fridge)
        Positioned(
          right: 32,
          bottom: 32,
          child: GestureDetector(
            onTap: _handleInventoryTap,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 3,
                ),
              ),
              alignment: Alignment.center,
              child: heldItemId == null
                  ? Text(
                      'empty',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 10,
                      ),
                    )
                  : Image.asset(
                      'assets/images/food/beef_steak.png',
                      width: 50,
                      height: 50,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

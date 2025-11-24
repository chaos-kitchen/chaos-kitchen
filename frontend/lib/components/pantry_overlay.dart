import 'package:chaos_kitchen/game/game.dart';
import 'package:flutter/material.dart';

class PantryOverlay extends StatelessWidget {
  final ChaosKitchenGame game;

  const PantryOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background pantry art
        Positioned.fill(
          child: Image.asset(
            'assets/images/backgrounds/pantry.png',
            fit: BoxFit.cover,
          ),
        ),

        // Back arrow
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                game.closePantry();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0), // bigger touch area
                child: Image.asset(
                  'assets/images/cross_small.png',
                  width: 40,
                  height: 40,
                  // color: Colors.white, // optional tint
                ),
              ),
            ),
          ),
        ),

        // TODO: ingredient hotspots / buttons go here later
      ],
    );
  }
}

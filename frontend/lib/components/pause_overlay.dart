import 'package:chaos_kitchen/components/button.dart';
import 'package:chaos_kitchen/game/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PauseOverlay extends StatelessWidget {
  final ChaosKitchenGame game;

  const PauseOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  const Text(
                    'Pause',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  UIButton(
                    onPressed: () {
                      game.closePauseMenu();
                    },
                    child: const Text('Resume Game'),
                  ),
                  UIButton(
                    onPressed: () {
                      GoRouter.of(context).go('/');
                    },
                    child: const Text('Exit Game'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

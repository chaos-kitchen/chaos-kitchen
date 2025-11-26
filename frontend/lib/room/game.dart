import 'package:chaos_kitchen/components/lobby_overlay.dart';
import 'package:chaos_kitchen/components/pause_overlay.dart';
import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/components/fridge_overlay.dart';
import 'package:chaos_kitchen/components/pantry_overlay.dart';
import 'package:chaos_kitchen/components/dough_mixer_overlay.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

// NOTE: GameScreen is a StatelessWidget, meaning the game will be
//       recreated on each hot-reload.
//       This is intentional because Flame does not support hot-reload.

class GameScreen extends StatelessWidget {
  final String roomId;
  final String playerName;

  const GameScreen({super.key, required this.roomId, required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget<ChaosKitchenGame>(
          game: ChaosKitchenGame(roomId: roomId, playerName: playerName),

          loadingBuilder: (context) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              ),
            );
          },

          overlayBuilderMap: {
            'fridge_overlay': (context, game) {
              return FridgeOverlay(game: game);
            },

            'pantry_overlay': (context, game) {
              return PantryOverlay(game: game);
            },

            'lobby_overlay': (context, game) {
              return LobbyOverlay(game: game);
            },

            'pause_overlay': (context, game) {
              return PauseOverlay(game: game);
            },

            'dough_mixer': (context, game) {
              return DoughMixerOverlay(game: game);
            },
          },
        ),
      ],
    );
  }
}

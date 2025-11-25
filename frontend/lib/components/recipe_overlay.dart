import 'package:chaos_kitchen/game/game.dart';
import 'package:flutter/material.dart';

class RecipeOverlay extends StatefulWidget {
  final ChaosKitchenGame game;

  const RecipeOverlay({super.key, required this.game});

  @override
  State<RecipeOverlay> createState() => _RecipeOverlayState();
}

class _RecipeOverlayState extends State<RecipeOverlay> {
  int _pageNumber = 0;
  final int _totalPages = 5;

  void _nextPage() {
    if (_pageNumber < _totalPages - 1) {
      setState(() {
        _pageNumber += 1;
      });
    }
  }

  void _previousPage() {
    if (_pageNumber > 0) {
      setState(() {
        _pageNumber -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/clipboard.png',
              fit: BoxFit.fitHeight,
            ),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                widget.game.closeRecipe();
              },
              child: Center(
                heightFactor: 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 250.0),
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

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _previousPage,
                    child: Image.asset(
                      'assets/images/arrow_curve_left.png',
                      width: 48,
                      height: 48,
                    ),
                  ),
                  const SizedBox(width: 60),

                  Text(
                    '${_pageNumber + 1}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(width: 60),
                  GestureDetector(
                    onTap: _nextPage,
                    child: Image.asset(
                      'assets/images/arrow_curve_right.png',
                      width: 48,
                      height: 48,
                    ),
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

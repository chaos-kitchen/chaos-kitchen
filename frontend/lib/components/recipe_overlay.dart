import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/ingredients.dart';
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
  final List<String> _requiredIngredients = [
    IngredientIds.flour,
    IngredientIds.butter,
    IngredientIds.water,
    IngredientIds.salt,
    IngredientIds.pepper,
    IngredientIds.mushrooms,
    IngredientIds.onionWhite,
    IngredientIds.garlic,
    IngredientIds.thyme,
    IngredientIds.beefFillet,
    IngredientIds.prosciutto,
    IngredientIds.eggs,
  ];

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

  Widget _ingredientsPage({required List<String> ingredientIds}) {
    return Column(
      children: [
        Text(
          'Ingredients',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemCount: ingredientIds.length,
          itemBuilder: (context, index) {
            final id = ingredientIds[index];
            final String? assetPath = ingredientAssetPaths[id];
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (assetPath != null)
                  Image.asset('assets/images/$assetPath', width: 50, height: 50)
                else
                  const SizedBox(width: 50, height: 50),
              ],
            );
          },
        ),
      ],
    );
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

          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 65.0, bottom: 40.0),
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              constraints: BoxConstraints(
                maxHeight:
                    MediaQuery.of(context).size.height -
                    0, // Account for margins
                maxWidth:
                    MediaQuery.of(context).size.width *
                    0.3, // % of screen width
              ),
              child: (_pageNumber == 0)
                  ? SingleChildScrollView(
                      child: _ingredientsPage(
                        ingredientIds: _requiredIngredients,
                      ),
                    )
                  : null,
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

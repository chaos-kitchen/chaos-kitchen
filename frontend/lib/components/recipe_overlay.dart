import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/ingredients.dart';
import 'package:chaos_kitchen/utils/defs.dart';
import 'package:flutter/material.dart';

Widget _text(String text) {
  return Text(
    text,
    textAlign: TextAlign.left,
    style: TextStyle(fontSize: 14, color: Colors.black),
  );
}

Widget _scribble(String text) {
  return Text(
    text,
    textAlign: TextAlign.left,
    style: TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontFamily: 'NothingYouCouldDo',
    ),
  );
}

class RecipeOverlay extends StatefulWidget {
  final ChaosKitchenGame game;

  const RecipeOverlay({super.key, required this.game});

  @override
  State<RecipeOverlay> createState() => _RecipeOverlayState();
}

class _RecipeOverlayState extends State<RecipeOverlay> {
  int _pageNumber = 0;
  final int _totalPages = 10;
  // step number to required ingredients
  final Map<int, List<String>> _requiredIngredients = {
    1: [
      IngredientIds.flour_blue, // will accept grey
      IngredientIds.butter,
      IngredientIds.water,
      IngredientIds.salt,
      IngredientIds.eggs,
    ],
    2: [
      IngredientIds.mushrooms,
      IngredientIds.onionWhite,
      IngredientIds.garlic,
      IngredientIds.thyme,
      IngredientIds.pepper,
    ],
    3: [
      IngredientIds.beefFillet,
      IngredientIds.salt,
      IngredientIds.pepper,
      IngredientIds.butter,
    ],
    4: [
      IngredientIds.prosciutto,
      IngredientIds.eggs,
      // pastry from step 1
      // mushroom filling from step 2
      // seared beef from step 3
    ],
  };

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

  Widget _titlePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Beef Wellington For Dummies',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'An Exclusively Free Guide With the Exact Quality You Paid For',
          style: TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _ingredientsList({
    required List<String>? ingredientIds,
    bool greyscale = false,
  }) {
    if (ingredientIds == null || ingredientIds.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
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
              greyscale
                  ? ColorFiltered(
                      colorFilter: greyscaleColorFilter,
                      child: Image.asset(
                        'assets/images/$assetPath',
                        width: 50,
                        height: 50,
                      ),
                    )
                  : Image.asset(
                      'assets/images/$assetPath',
                      width: 50,
                      height: 50,
                    )
            else
              const SizedBox(width: 50, height: 50),
          ],
        );
      },
    );
  }

  Widget _buildStandardPage({required String title, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.0,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(child: SingleChildScrollView(child: content)),
      ],
    );
  }

  Widget _getPageContent() {
    switch (_pageNumber) {
      case 0:
        return _titlePage();
      case 1:
        return _buildStandardPage(
          title: 'Step 1: Pastry Dough',
          content: Column(
            children: [
              _text('You will need the following:'),
              _ingredientsList(ingredientIds: _requiredIngredients[1]),
              _scribble(
                'Running low on the blue bag, use the grey one if needed!',
              ),
            ],
          ),
        );
      case 2:
        return _buildStandardPage(
          title: 'Step 1: Pastry Dough',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/ingredients_into_bowl.png'),
              const SizedBox(height: 10),
              Image.asset('assets/images/dough_into_fridge.png'),
            ],
          ),
        );
      case 3:
        return _buildStandardPage(
          title: 'Step 2: Filling',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _text('You will need the following:'),
              _ingredientsList(
                ingredientIds: _requiredIngredients[2],
                greyscale: true,
              ),
              _scribble('We really need to fix the darn printer...'),
              _scribble('are those onions red or white again?'),
            ],
          ),
        );
      case 4:
        return _buildStandardPage(
          title: 'Step 2: Filling',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble('Shade-born caps: make them many.'), // chop mushrooms
              const SizedBox(height: 10),
              _scribble('The pale sphere: peel, scatter.'), // chop onion
              const SizedBox(height: 10),
              _scribble('Vampires\' bane: dice fine.'), // crush garlic
              const SizedBox(height: 10),
              _scribble('Fanged shards, tiny green ticks—add.'), // chop thyme
            ],
          ),
        );
      case 5:
        return _buildStandardPage(
          title: 'Step 2: Filling',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble('Dark planets stay whole.'), // pepper
              const SizedBox(height: 10),
              _scribble('In the silver cauldron, they will meet.'), // mix all
              const SizedBox(height: 10),
              _scribble('Send the warm murmur to the cold vault.'), // fridge
              const SizedBox(height: 10),
              _text('Auto translated to Eldritch Cant by DeepOpenGeminAI™.'),
              const SizedBox(height: 5),
              Text(
                'LLMs can make mistakes.',
                style: TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ),
        );
      case 6:
        return _buildStandardPage(
          title: 'Step 3: Beef Fillet',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _text('You will need the following:'),
              _ingredientsList(ingredientIds: _requiredIngredients[3]),
              _scribble('Is it fillet or filet again?'),
            ],
          ),
        );
      case 7:
        return _buildStandardPage(
          title: 'Step 3: Beef Fillet',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble(
                'Do not not heat the pan until it does not fail to smoke.',
              ),
              const SizedBox(height: 10),
              _scribble('Do not don’t leave the fillet unmoved.'),
              const SizedBox(height: 10),
              _scribble(
                'Do not avoid flipping when it no longer refuses release.',
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      case 8:
        return _buildStandardPage(
          title: 'Step 3: Beef Fillet',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble(
                'Do not don\'t count not less than sixty beats per face.',
              ),
              const SizedBox(height: 10),
              _scribble(
                'Do not keep the fire on when the crust isn\'t not mahogany.',
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
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

          Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(top: 65.0, bottom: 40.0),
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                constraints: BoxConstraints(
                  maxHeight:
                      MediaQuery.of(context).size.height -
                      130, // Account for margins
                  maxWidth:
                      MediaQuery.of(context).size.width *
                      0.3, // % of screen width
                ),
                child: _getPageContent(),
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

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 250.0, top: 10.0),
              child: GestureDetector(
                onTap: () {
                  widget.game.closeRecipe();
                },
                child: Image.asset(
                  'assets/images/cross_small.png',
                  width: 32,
                  height: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

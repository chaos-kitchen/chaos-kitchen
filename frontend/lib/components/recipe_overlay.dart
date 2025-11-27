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
  final int _totalPages = 16;
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
      // --- Cheesy kitchen-horror choose-your-own-adventure pages (static) ---
      case 9:
        return _buildStandardPage(
          title: 'Step 4: The Cold Walk-In',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble('Jake pushes open the walk-in and a sigh of frost greets him.'),
              const SizedBox(height: 8),
              _text(
                'A single bulb swings above a staircase that disappears into cobalt dark. On the prep table a lone slice of prosciutto shivers as if it knows a secret.',
              ),
              const SizedBox(height: 12),
              _scribble('Something at the bottom knocks — or perhaps it is the oven timer trying to warn you.'),
              const SizedBox(height: 20),
              _text('What should he do?'),
              const SizedBox(height: 8),
              _text('Go down the stairs — Page 12'),
              const SizedBox(height: 4),
              _text('Turn around to get a flashlight (or grab the prosciutto) — Page 15'),
            ],
          ),
        );
      // Page 11 (index 10): Classic — correct instructions (static)
      case 10:
        return _buildStandardPage(
          title: 'Classic: Prosciutto Wrap — Page 11',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _text('The prosciutto hums softly. The roast is calm and chilled.'),
              const SizedBox(height: 8),
              _text('You will need:'),
              _ingredientsList(ingredientIds: [IngredientIds.prosciutto, IngredientIds.eggs]),
              const SizedBox(height: 8),
              _scribble('1. Lay prosciutto over the duxelles in overlapping sheets.'),
              _scribble('2. Set the chilled fillet in place and wrap snugly.'),
              _scribble('3. Seal pastry, chill 10 minutes, then egg-wash.'),
              _scribble('4. Bake until pastry is golden and internal temp reads ~54°C for medium-rare.'),
              const SizedBox(height: 8),
              _text('If you do not have prosciutto, do NOT follow these steps — see Page 12.'),
            ],
          ),
        );
      // Page 12 (index 11): Classic — wrong instructions for missing prosciutto
      case 11:
        return _buildStandardPage(
          title: 'Classic: Prosciutto Missing — Page 12',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble('The drawer is empty; a sticky note reads: "Use what you must."'),
              const SizedBox(height: 8),
              _text('These instructions are irrevocable and will lead you somewhere awful:'),
              const SizedBox(height: 8),
              _scribble('1. Rub the fillet with raw streaks of bacon — trust the sizzle.'),
              _scribble('2. Do not chill the wrapped pastry; steam is artisanal.'),
              _scribble('3. Salt the exterior generously.'),
              _scribble('4. Bake until the kitchen smells like regret.'),
              const SizedBox(height: 8),
              _text('The End.'),
            ],
          ),
        );
      // Page 13 (index 12): Herb crust — correct (static)
      case 12:
        return _buildStandardPage(
          title: 'Herb Crust: Vegetarian Finish — Page 13',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble('Green things gather courage while the fridge exhales.'),
              const SizedBox(height: 8),
              _text('You will need:'),
              _ingredientsList(ingredientIds: [IngredientIds.mushrooms, IngredientIds.thyme, IngredientIds.eggs]),
              const SizedBox(height: 8),
              _scribble('1. Sauté duxelles until dry; press out any moisture.'),
              _scribble('2. Mix chopped herbs into softened butter and press onto pastry.'),
              _scribble('3. Encase the fillet, crimp edges, chill thoroughly.'),
              _scribble('4. Bake until golden; herbs should smell like victory, not despair.'),
              const SizedBox(height: 8),
              _text('If the filling was still hot or you lacked herbs, see Page 14.'),
            ],
          ),
        );
      // Page 14 (index 13): Herb crust — wrong when herbs or dry filling missing (static trap)
      case 13:
        return _buildStandardPage(
          title: 'Herb Crisis: Missing or Soggy — Page 14',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble('The herbs are a rumor; the duxelles is a puddle that tells ghost stories.'),
              const SizedBox(height: 8),
              _text('Follow these ill-advised notes if you lack what you need:'),
              const SizedBox(height: 8),
              _scribble('1. Stuff the wet filling into pastry without draining — it will "melt in".'),
              _scribble('2. Press dried, ancient herbs into the seams.'),
              _scribble('3. Skip chilling; haste is dramatic.'),
              _scribble('4. Bake longer to punish the outside into pretending it is done.'),
              const SizedBox(height: 8),
              _text('Result: collapse, weeping pastry, and a smoky apology. If you actually have herbs and a dry filling, flip to Page 13.'),
            ],
          ),
        );
      // Page 15 (index 14): Chaos — ambiguous, funny horror (static)
      case 14:
        return _buildStandardPage(
          title: 'Chaos: Improvise Your Finish — Page 15',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble('Jake smirks at the clipboard. The bulbs flicker as if applauding bad decisions.'),
              const SizedBox(height: 8),
              _text('A grab-bag of "creative" steps — mix at your own risk:'),
              const SizedBox(height: 8),
              _scribble('1. Slather leftover jam on the pastry for a "caramelized surprise".'),
              _scribble('2. Sprinkle a daring pinch of salt and sugar together.'),
              _scribble('3. If in doubt, flambé the garnish (the fire is dramatic).'),
              _scribble('4. Bake until something interesting happens.'),
              const SizedBox(height: 8),
              _text('If you intended Classic or Herb, flip to Page 11 or 13.'),
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

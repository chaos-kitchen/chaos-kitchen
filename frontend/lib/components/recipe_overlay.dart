import 'package:chaos_kitchen/game/game.dart';
import 'package:chaos_kitchen/game/ingredients.dart';
import 'package:chaos_kitchen/utils/defs.dart';
import 'package:flutter/material.dart';

Widget _text(String text) {
  return Text(
    text,
    textAlign: TextAlign.left,
    style: TextStyle(fontSize: 12, color: Colors.black),
  );
}

Widget _smallText(String text) {
  return Text(
    text,
    textAlign: TextAlign.left,
    style: TextStyle(
      fontSize: 10,
      color: Colors.black,
      fontStyle: FontStyle.italic,
    ),
  );
}

Widget _scribble(String text) {
  return Text(
    text,
    textAlign: TextAlign.left,
    style: TextStyle(
      fontSize: 12,
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
  final int _totalPages = 19;
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'An Exclusively Free Guide With the Exact Quality You Paid For',
          style: TextStyle(
            fontSize: 15,
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

  Widget _buildStandardPage({required String? title, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
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
              const SizedBox(height: 10),
              _scribble('Shade-born caps, make them many.'), // chop mushrooms
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
              const SizedBox(height: 10),
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
              _scribble(
                'Pork tenderloin is NOT a substitute. Looking at you, Dave.',
              ),
              _scribble('         — Management'),
            ],
          ),
        );
      case 7:
        return _buildStandardPage(
          title: 'Step 3: Beef Fillet',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _scribble(
                'Do not not heat the pan until it does not fail to smoke.',
              ),
              const SizedBox(height: 10),
              _scribble('Do not don\'t leave the fillet unmoved.'),
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
              const SizedBox(height: 10),
              _scribble(
                'Do not don\'t count not less than 8 seconds per face.',
              ),
              const SizedBox(height: 10),
              _scribble(
                'Do not keep the fire on when the crust isn\'t not mahogany.',
              ),
            ],
          ),
        );
      case 9:
        return _buildStandardPage(
          title: 'Step 4: Assembly',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              _scribble('They call him Chef Gordon.'),
              const SizedBox(height: 8),
              _scribble(
                'Tonight he prowls the prep station, convinced the perfect dish will earn him immortality.',
              ),
              const SizedBox(height: 10),
              _text('How do you survive?'),
              const SizedBox(height: 4),
              _smallText('Offer prosciutto as tribute — Page 11'),
              const SizedBox(height: 4),
              _smallText('Distract Chef Gordon with an herb show — Page 13'),
              const SizedBox(height: 4),
              _smallText(
                'Call Chef Gordon an "Idiot Sandwich" to stun him — Page 15',
              ),
            ],
          ),
        );
      // Page 11 (index 10): Prosciutto success (static)
      case 10:
        return _buildStandardPage(
          title: null,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble(
                'Chef Gordon inhales; the prosciutto has been acknowledged.',
              ),
              const SizedBox(height: 8),
              _smallText('He reveals the ingredients:'),
              _ingredientsList(
                ingredientIds: [IngredientIds.prosciutto, IngredientIds.eggs],
              ),
              const SizedBox(height: 4),
              _smallText(
                'He scrunches his face, "A true chef would have known that..."',
              ),
              const SizedBox(height: 8),
              _smallText('You say:'),
              const SizedBox(height: 2),
              _smallText('"Yes Chef! I was just testing you." — Page 16'),
              const SizedBox(height: 2),
              _smallText('"I\'ve never claimed to be a great chef." — Page 15'),
            ],
          ),
        );
      // Page 12 (index 11): Prosciutto missing — trap (static)
      case 11:
        return _buildStandardPage(
          title: null,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble('No prosciutto? Chef Gordon grabs bacon instead.'),
              const SizedBox(height: 8),
              _text('The bacon shrinks. The pastry cracks. The filling leaks.'),
              const SizedBox(height: 8),
              _scribble(
                '"This isn\'t Beef Wellington—it\'s a soggy bacon burrito!"',
              ),
              const SizedBox(height: 8),
              _text('The End. Everything was wrong from the start.'),
            ],
          ),
        );
      // Page 13 (index 12): Herb success (static)
      case 12:
        return _buildStandardPage(
          title: null,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble(
                'You wave herbs around like a wizard. Chef Gordon is momentarily enchanted.',
              ),
              const SizedBox(height: 8),
              _smallText('He reveals the ingredients:'),
              _ingredientsList(
                ingredientIds: [
                  IngredientIds.mushrooms,
                  IngredientIds.thyme,
                  IngredientIds.eggs,
                ],
              ),
              const SizedBox(height: 8),
              _smallText(
                'He squints at you. "You know what you\'re doing... right?"',
              ),
              const SizedBox(height: 8),
              _smallText('You respond:'),
              const SizedBox(height: 2),
              _smallText(
                '"Of course, Chef! Herbs are my specialty." — Page 12',
              ),
              const SizedBox(height: 2),
              _smallText('"I\'m winging it, honestly." — Page 15'),
            ],
          ),
        );
      // Page 14 (index 13): Herb missing / wet filling — trap (static)
      case 13:
        return _buildStandardPage(
          title: null,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              _smallText('He whispers:'),
              const SizedBox(height: 2),
              _smallText(
                '"I will tell you the secret step, if you can answer this question truly."',
              ),
              const SizedBox(height: 8),
              _scribble('What is the greatest sin in cooking?'),
              const SizedBox(height: 8),
              _smallText('Your answer:'),
              const SizedBox(height: 2),
              _smallText('"Undercooking." — Page 18'),
              const SizedBox(height: 2),
              _smallText('"Being a pompous know-it-all like you." — Page 15'),
              const SizedBox(height: 2),
              _smallText('"Overcooking." — Page 17'),
            ],
          ),
        );
      // Page 15 (index 14): Chaos — comedic horror (static)
      case 14:
        return _buildStandardPage(
          title: null,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble(
                'You\'ve disrespected Chef Gordon. His eyes narrow into slits of pure rage.',
              ),
              const SizedBox(height: 4),
              _text('At first, Chef Gordon is stunned.'),
              const SizedBox(height: 4),
              _scribble(
                'But then, his eyes blaze like searing pans, and his apron seems to writhe with a life of its own. The last thing you see are two slices of bread clamped to your head.',
              ),
              const SizedBox(height: 4),
              _text('The End.'),
            ],
          ),
        );
      case 15:
        return _buildStandardPage(
          title: null,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              _smallText(
                'Chef Gordon nods approvingly. He gives you the secret recipe:',
              ),
              const SizedBox(height: 4),
              _scribble('1. Lay out the dough, and put filling over it.'),
              const SizedBox(height: 4),
              _scribble('2. Lay prosciutto over the filling in strips.'),
              const SizedBox(height: 4),
              _scribble('3. Place fillet, wrap snugly.'),
              const SizedBox(height: 8),
              _scribble(
                'Chef Gordon leans in close. "There\'s a secret step I\'ve told nobody before. It\'s the key to perfection."',
              ),
              const SizedBox(height: 8),
              _smallText('Go to Page 14'),
            ],
          ),
        );
      case 16:
        return _buildStandardPage(
          title: null,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble(
                'Chef Gordon\'s face turns purple. "Overcooking? That\'s amateur hour!"',
              ),
              const SizedBox(height: 4),
              _text(
                'He banishes you to the walk-in freezer with nothing but a loaf of bread.',
              ),
              const SizedBox(height: 4),
              _scribble(
                'You emerge hours later, frostbitten and enlightened. But the Wellington? Forgotten.',
              ),
              const SizedBox(height: 4),
              _text('The End.'),
            ],
          ),
        );
      case 17:
        return _buildStandardPage(
          title: null,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble(
                'Chef Gordon nods solemnly. "Yes... undercooking is the true evil."',
              ),
              const SizedBox(height: 4),
              _smallText('Very well. You\'ve proven your worth.'),
              const SizedBox(height: 4),
              _scribble(
                'You must egg wash the pastry thoroughly, sealing in the juices and ensuring a golden crust.',
              ),
              const SizedBox(height: 4),
              _smallText(
                'With that, he vanishes into the shadows, leaving you to finish.',
              ),
              const SizedBox(height: 8),
              _text(
                'Congratulations! You\'ve unlocked the true path to Beef Wellington mastery.',
              ),
            ],
          ),
        );
      case 18:
        return _buildStandardPage(
          title: 'Step 5: Baking',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _scribble('Preheat the fiery chamber to (420°F).'),
              const SizedBox(height: 10),
              _scribble('Place the assembled Wellington on a baking tray.'),
              const SizedBox(height: 10),
              _scribble('Bake for 30s, or until the pastry is golden brown.'),
              const SizedBox(height: 10),
              _scribble('Let it rest before slicing to serve.'),
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
          Positioned.fill(child: Container(color: Colors.black54)),

          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/clipboard.png',
                fit: BoxFit.fitHeight,
              ),
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
              padding: const EdgeInsets.only(bottom: 20.0),
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
                  const SizedBox(width: 40),

                  Text(
                    '${_pageNumber + 1}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(width: 40),
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
              padding: const EdgeInsets.only(left: 170.0, top: 50.0),
              child: GestureDetector(
                onTap: () {
                  widget.game.closeRecipe();
                },
                child: Image.asset(
                  'assets/images/cross_small.png',
                  width: 32,
                  height: 32,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

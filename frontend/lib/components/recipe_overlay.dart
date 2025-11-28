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
              _scribble('They call him Chef Gordon.'),
              const SizedBox(height: 8),
              _text(
                'Chef Gordon worships one thing above all: Beef Wellington. He hums sea shanties to pastry and speaks to prosciutto as if it owes him money.',
              ),
              const SizedBox(height: 12),
              _scribble(
                'Tonight he prowls the prep station, convinced the perfect seared beef will earn him culinary immortality (or at least a good Yelp line).',
              ),
              const SizedBox(height: 20),
              _text('What should you do?'),
              const SizedBox(height: 8),
              _text(
                'Offer prosciutto as tribute to calm Chef Gordon — Page 11',
              ),
              const SizedBox(height: 4),
              _text('Distract Chef Gordon with an herb show — Page 13'),
              const SizedBox(height: 4),
              _text(
                'Call Chef Gordon an "Idiot Sandwich" to stun him — Page 15',
              ),
            ],
          ),
        );
      // Page 11 (index 10): Prosciutto success (static)
      case 10:
        return _buildStandardPage(
          title: 'Step 4: Tribute Accepted — Page 11',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble(
                'Chef Gordon inhales; for a blessed second he is placid. The prosciutto has been acknowledged.',
              ),
              const SizedBox(height: 8),
              _text('You will need:'),
              _ingredientsList(
                ingredientIds: [IngredientIds.prosciutto, IngredientIds.eggs],
              ),
              const SizedBox(height: 8),
              _scribble(
                '1. Lay prosciutto over the duxelles in neat, reverent strips.',
              ),
              _scribble(
                '2. Place chilled fillet, wrap snugly so juices stay scandal-free.',
              ),
              _scribble(
                '3. Seal pastry, chill 10 minutes; egg-wash for gloss that impresses critics and chefs alike.',
              ),
              _scribble(
                '4. Bake until pastry is golden and internal temp ~54°C for medium-rare. Present with a confident nod.',
              ),
              const SizedBox(height: 8),
              _text(
                'If you do not have prosciutto, do NOT follow these steps — flip to Page 12 for the bleak improv.',
              ),
            ],
          ),
        );
      // Page 12 (index 11): Prosciutto missing — trap (static)
      case 11:
        return _buildStandardPage(
          title: 'Step 4: Gordon\'s Displeasure — Page 12',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble(
                'The prosciutto drawer is a rumor. Chef Gordon frowns like thunder.',
              ),
              const SizedBox(height: 8),
              _text(
                'These are the instructions left by someone who mistook improvisation for genius:',
              ),
              const SizedBox(height: 8),
              _scribble(
                '1. Rub the fillet with raw bacon ribbons — rawness is "personality".',
              ),
              _scribble('2. Skip chilling; steam is edgy and memorable.'),
              _scribble('3. Salt the outside until the pan files a complaint.'),
              _scribble('4. Bake until the smoke alarm votes no confidence.'),
              const SizedBox(height: 8),
              _text(
                'Outcome: soggy pastry, over-salted meat, and an enraged chef. If you actually have prosciutto, flip to Page 11.',
              ),
            ],
          ),
        );
      // Page 13 (index 12): Herb success (static)
      case 12:
        return _buildStandardPage(
          title: 'Step 4: Herb Theatre — Page 13',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble(
                'You stage an herb spectacle. Chef Gordon is momentarily distracted by the aromatics.',
              ),
              const SizedBox(height: 8),
              _text('You will need:'),
              _ingredientsList(
                ingredientIds: [
                  IngredientIds.mushrooms,
                  IngredientIds.thyme,
                  IngredientIds.eggs,
                ],
              ),
              const SizedBox(height: 8),
              _scribble(
                '1. Sauté duxelles until dry; remove excess moisture — drama is scent, not soup.',
              ),
              _scribble(
                '2. Fold chopped thyme into softened butter and press onto pastry like a tiny green flag.',
              ),
              _scribble(
                '3. Encase the fillet, crimp edges, chill thoroughly so structure holds.',
              ),
              _scribble('4. Bake until golden; let the herbs sing, not wail.'),
              const SizedBox(height: 8),
              _text(
                'If the filling was still hot or you lacked herbs, flip to Page 14 for the soggy disaster.',
              ),
            ],
          ),
        );
      // Page 14 (index 13): Herb missing / wet filling — trap (static)
      case 13:
        return _buildStandardPage(
          title: 'Step 4: Herbless Tragedy — Page 14',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble(
                'The herbs are a myth; the duxelles is a puddle that giggles. Chef Gordon does not approve.',
              ),
              const SizedBox(height: 8),
              _text('Follow these steps only if you enjoy dramatic collapse:'),
              const SizedBox(height: 8),
              _scribble(
                '1. Stuff the wet filling into the pastry without draining — the leak is "interesting".',
              ),
              _scribble('2. Patch with withered herbs like a sad bandage.'),
              _scribble('3. Skip chilling; haste impresses no one but regret.'),
              _scribble(
                '4. Bake longer to make the outside forget the inside exists.',
              ),
              const SizedBox(height: 8),
              _text(
                'Result: collapsed pastry and a chef who mutters something that sounds like a recipe for vengeance. If you have herbs and a dry filling, flip to Page 13.',
              ),
            ],
          ),
        );
      // Page 15 (index 14): Chaos — comedic horror (static)
      case 14:
        return _buildStandardPage(
          title: 'Step 4: Gordon Unleashed',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scribble(
                '"What are you?", you ask. Before he can answer, you shout "You\'re an idiot sandwich!"',
              ),
              const SizedBox(height: 8),
              _text(
                'At first, Chef Gordon is stunned. You even see a flicker of doubt in his eyes.',
              ),
              const SizedBox(height: 8),
              _scribble(
                'But then, a terrifying transformation begins. His eyes blaze like searing pans, and his apron seems to writhe with a life of its own.',
              ),
              const SizedBox(height: 20),
              _text('You died.'),
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

class IngredientIds {
  static const flour = 'flour';
  static const flour_blue = 'flour_blue';
  static const butter = 'butter';
  static const water = 'water';
  static const salt = 'salt';
  static const pepper = 'pepper';
  static const mushrooms = 'mushrooms';
  static const onionWhite = 'onion_white';
  static const garlic = 'garlic';
  static const thyme = 'thyme';
  static const beefFillet = 'beef_fillet';
  static const prosciutto = 'prosciutto';
  static const eggs = 'eggs';
  static const beefSteak = 'beef_steak'; // existing one, keep for now

  static const dough = 'dough';
  static const doughBad = 'dough_bad';
  static const coal = 'coal';

  static const cuttingBoard = 'cutting_board';
  static const cuttingBoardOnion = 'cutting_board_onion';
  static const cuttingBoardGarlic = 'cutting_board_garlic';
  static const cuttingBoardMushroom = 'cutting_board_mushroom';
  static const cuttingBoardThyme = 'cutting_board_thyme';

  // chopped ingredients
  static const choppedGarlic = 'chopped_garlic';
  static const choppedMushroom = 'chopped_mushroom';
  static const choppedOnions = 'chopped_onions';
  static const choppedThyme = 'chopped_thyme';
}

const Map<String, String> ingredientAssetPaths = {
  IngredientIds.flour: 'food/flour_grey.png',
  IngredientIds.flour_blue: 'food/flour_blue.png',
  IngredientIds.butter: 'food/butter.png',
  IngredientIds.water: 'measuring_cup_water.png',
  IngredientIds.salt: 'food/salt.png',
  IngredientIds.pepper: 'food/pepper.png',
  IngredientIds.mushrooms: 'food/mushrooms_cremini.png',
  IngredientIds.onionWhite: 'food/onions_white.png',
  IngredientIds.garlic: 'food/garlic.png',
  IngredientIds.thyme: 'food/thyme.png',
  IngredientIds.beefFillet: 'food/beef_fillet.png',
  IngredientIds.prosciutto: 'food/prosciutto.png',
  IngredientIds.eggs: 'food/eggs.png',
  IngredientIds.dough: 'food/dough.png',
  IngredientIds.doughBad: 'food/dough_bad.png',
  IngredientIds.coal: 'food/coal.png',
  IngredientIds.cuttingBoard: 'cutting_board.png',
  IngredientIds.cuttingBoardOnion: 'cutting_board_onion.png',
  IngredientIds.cuttingBoardGarlic: 'cutting_board_garlic.png',
  IngredientIds.cuttingBoardMushroom: 'cutting_board_mushroom.png',
  IngredientIds.cuttingBoardThyme: 'cutting_board_thyme.png',

  // existing
  IngredientIds.beefSteak: 'food/beef_steak.png',

  // chopped ingredients
  IngredientIds.choppedGarlic: 'food/garlic_chopped.png',
  IngredientIds.choppedMushroom: 'food/mushrooms_cremini_chopped.png',
  IngredientIds.choppedOnions: 'food/onions_white_chopped.png',
  IngredientIds.choppedThyme: 'food/thyme_chopped.png',
};

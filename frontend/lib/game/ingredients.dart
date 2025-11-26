class IngredientIds {
  static const flour = 'flour';
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
}

const Map<String, String> ingredientAssetPaths = {
  IngredientIds.flour: 'food/flour_grey.png',
  IngredientIds.butter: 'food/butter.png',
  IngredientIds.water: 'food/can_blue.png',
  IngredientIds.salt: 'food/salt.png',
  IngredientIds.pepper: 'food/pepper.png',
  IngredientIds.mushrooms: 'food/mushrooms_cremini.png',
  IngredientIds.onionWhite: 'food/onions_white.png',
  IngredientIds.garlic: 'food/garlic.png',
  IngredientIds.thyme: 'food/thyme.png',
  IngredientIds.beefFillet: 'food/beef_fillet.png',
  IngredientIds.prosciutto: 'food/prosciutto.png',
  IngredientIds.eggs: 'food/eggs.png',

  // existing
  IngredientIds.beefSteak: 'food/beef_steak.png',
};

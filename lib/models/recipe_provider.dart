import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'recipe.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  Set<String> _favorites = {};

  List<Recipe> get recipes => _recipes;
  Set<String> get favorites => _favorites;

  RecipeProvider() {
    _loadSampleData();
    _loadFavorites();
  }

  void _loadSampleData() {
    _recipes = [
      Recipe(
        id: '1',
        name: 'Spaghetti Carbonara',
        description: 'Classic Italian pasta dish',
        ingredients: [
          'Spaghetti',
          'Eggs',
          'Pecorino Romano',
          'Guanciale',
          'Black pepper'
        ],
        instructions: [
          'Boil pasta',
          'Cook guanciale',
          'Mix eggs and cheese',
          'Combine all ingredients'
        ],
        cookingTime: 30,
        difficulty: 'Medium',
        category: 'Italian',
      ),
      Recipe(
        id: '2',
        name: 'Caesar Salad',
        description: 'Fresh and crispy salad',
        ingredients: [
          'Romaine lettuce',
          'Croutons',
          'Parmesan',
          'Caesar dressing'
        ],
        instructions: [
          'Wash lettuce',
          'Make dressing',
          'Combine ingredients',
          'Add cheese'
        ],
        cookingTime: 15,
        difficulty: 'Easy',
        category: 'Salads',
      ),
    ];
  }

  Future<void> toggleFavorite(String recipeId) async {
    if (_favorites.contains(recipeId)) {
      _favorites.remove(recipeId);
    } else {
      _favorites.add(recipeId);
    }
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favorites.toList());
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites = Set.from(prefs.getStringList('favorites') ?? []);
    notifyListeners();
  }
}

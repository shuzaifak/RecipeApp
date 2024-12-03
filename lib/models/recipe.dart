// lib/models/recipe.dart
class Recipe {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final int cookingTime;
  final String difficulty;
  final String category;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.cookingTime,
    required this.difficulty,
    required this.category,
  });
}

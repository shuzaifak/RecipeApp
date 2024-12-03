// Add this code in lib/widgets/recipe_search_delegate.dart
import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'recipe_details.dart';

class RecipeSearchDelegate extends SearchDelegate<Recipe?> {
  final List<Recipe> recipes;

  RecipeSearchDelegate(this.recipes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchResults();
  }

  Widget buildSearchResults() {
    final results = recipes
        .where((recipe) =>
            recipe.name.toLowerCase().contains(query.toLowerCase()) ||
            recipe.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final recipe = results[index];
        return ListTile(
          title: Text(recipe.name),
          subtitle: Text(recipe.description),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetail(recipe: recipe),
              ),
            );
          },
        );
      },
    );
  }
}

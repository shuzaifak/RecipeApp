// lib/widgets/favorites_list.dart
import 'package:flutter/material.dart';
import 'package:ios/widgets/recipe_list.dart';
import 'package:provider/provider.dart';
import '../models/recipe_provider.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, recipeProvider, child) {
        final favoriteRecipes = recipeProvider.recipes
            .where((recipe) => recipeProvider.favorites.contains(recipe.id))
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorites'),
          ),
          body: favoriteRecipes.isEmpty
              ? const Center(
                  child: Text('No favorites yet'),
                )
              : ListView.builder(
                  itemCount: favoriteRecipes.length,
                  itemBuilder: (context, index) {
                    return RecipeCard(recipe: favoriteRecipes[index]);
                  },
                ),
        );
      },
    );
  }
}

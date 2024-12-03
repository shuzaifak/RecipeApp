// lib/widgets/recipe_list.dart
import 'package:flutter/material.dart';
import 'package:ios/models/recipe.dart';
import 'package:ios/widgets/recipe_search_delegate.dart';
import 'package:provider/provider.dart';
import '../models/recipe_provider.dart';
import 'recipe_details.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, recipeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recipes'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: RecipeSearchDelegate(recipeProvider.recipes),
                  );
                },
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: recipeProvider.recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipeProvider.recipes[index];
              return RecipeCard(recipe: recipe);
            },
          ),
        );
      },
    );
  }
}

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(recipe.name),
        subtitle: Text(recipe.description),
        trailing: Consumer<RecipeProvider>(
          builder: (context, recipeProvider, child) {
            return IconButton(
              icon: Icon(
                recipeProvider.favorites.contains(recipe.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: recipeProvider.favorites.contains(recipe.id)
                    ? Colors.red
                    : null,
              ),
              onPressed: () => recipeProvider.toggleFavorite(recipe.id),
            );
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetail(recipe: recipe),
            ),
          );
        },
      ),
    );
  }
}

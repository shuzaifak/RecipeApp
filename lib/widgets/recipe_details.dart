// lib/widgets/recipe_detail.dart
import 'package:flutter/material.dart';
import 'package:ios/models/recipe.dart';
import 'package:provider/provider.dart';
import '../models/recipe_provider.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetail({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          Consumer<RecipeProvider>(
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
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            _buildSection(context, 'Ingredients', recipe.ingredients),
            const SizedBox(height: 16),
            _buildSection(context, 'Instructions', recipe.instructions),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.arrow_right),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            )),
      ],
    );
  }
}

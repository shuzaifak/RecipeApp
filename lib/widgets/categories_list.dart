// lib/widgets/categories_list.dart
import 'package:flutter/material.dart';
import 'package:ios/widgets/recipe_list.dart';
import 'package:provider/provider.dart';
import '../models/recipe_provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, recipeProvider, child) {
        final categories = recipeProvider.recipes
            .map((recipe) => recipe.category)
            .toSet()
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Categories'),
          ),
          body: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index]),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDetail(
                        category: categories[index],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class CategoryDetail extends StatelessWidget {
  final String category;

  const CategoryDetail({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
      builder: (context, recipeProvider, child) {
        final categoryRecipes = recipeProvider.recipes
            .where((recipe) => recipe.category == category)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(category),
          ),
          body: ListView.builder(
            itemCount: categoryRecipes.length,
            itemBuilder: (context, index) {
              return RecipeCard(recipe: categoryRecipes[index]);
            },
          ),
        );
      },
    );
  }
}

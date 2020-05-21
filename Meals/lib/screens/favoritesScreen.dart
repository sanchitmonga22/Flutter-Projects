import 'package:Meals/models/meal.dart';
import 'package:Meals/widgets/mealItem.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text("You have no favorites, Please add favorites!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          var currentMeal = favoriteMeals[index];
          return MealItem(
            id: currentMeal.id,
            title: currentMeal.title,
            imageUrl: currentMeal.imageUrl,
            duration: currentMeal.duration,
            complexity: currentMeal.complexity,
            affordability: currentMeal.affordability,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}

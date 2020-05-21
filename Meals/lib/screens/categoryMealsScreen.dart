import 'package:Meals/widgets/mealItem.dart';
import 'package:flutter/material.dart';
import '../dummyCategories.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = 'categories-meals';
  // final String categoryID;
  // final String categoryTitle;

  // const CategoryMealsScreen({Key key, this.categoryID, this.categoryTitle})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryID = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryID))
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            var currentMeal = categoryMeals[index];
            return MealItem(
                id: currentMeal.id,
                title: currentMeal.title,
                imageUrl: currentMeal.imageUrl,
                duration: currentMeal.duration,
                complexity: currentMeal.complexity,
                affordability: currentMeal.affordability);
          },
          itemCount: categoryMeals.length,
        ));
  }
}

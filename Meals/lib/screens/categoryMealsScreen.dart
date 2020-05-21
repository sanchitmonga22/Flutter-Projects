import 'package:Meals/models/meal.dart';
import 'package:Meals/widgets/mealItem.dart';
import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'categories-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayMeals;
  bool loadedInitData = false;
  @override
  void didChangeDependencies() {
    if (!loadedInitData) {
      super.didChangeDependencies();
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryID = routeArgs['id'];
      displayMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryID))
          .toList();
      loadedInitData = true;
    }
  }

  void _removeMeal(String mealID) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            var currentMeal = displayMeals[index];
            return MealItem(
              id: currentMeal.id,
              title: currentMeal.title,
              imageUrl: currentMeal.imageUrl,
              duration: currentMeal.duration,
              complexity: currentMeal.complexity,
              affordability: currentMeal.affordability,
              removeItem: _removeMeal,
            );
          },
          itemCount: displayMeals.length,
        ));
  }
}

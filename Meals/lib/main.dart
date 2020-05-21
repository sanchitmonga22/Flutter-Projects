import 'package:Meals/dummyCategories.dart';
import 'package:Meals/screens/categoriesScreen.dart';
import 'package:Meals/screens/categoryMealsScreen.dart';
import 'package:Meals/screens/filtersScreen.dart';
import 'package:Meals/screens/mealDetails.dart';
import 'package:Meals/screens/tabsScreen.dart';
import 'package:flutter/material.dart';

import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (filterData['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (filterData['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (filterData['vegan'] && !meal.isVegan) {
          return false;
        }
        if (filterData['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorite(String mealID) {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealID);
    if (existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealID));
      });
    }
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed'))),
      initialRoute:
          '/', // this is by default single slash, but we can change that
      routes: {
        '/': (context) => TabsScreen(favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailsScreen.routeName: (context) =>
            MealDetailsScreen(toggleFavorite, isMealFavorite),
        FiltersScreen.routeName: (context) => FiltersScreen(
              saveFilters: setFilters,
            ),
      },

      // This is used when there is no route available to go when you click to go to a new route
      // onGenerateRoute: (settings){
      //   return MaterialPageRoute(builder: (context)=> CategoriesScreen());
      // },

      // This is used when there is an error loading a page or the app crashes.. so We can fallback to this page.
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}

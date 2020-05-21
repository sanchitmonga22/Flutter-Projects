import 'package:Meals/widgets/categoryItem.dart';
import 'package:flutter/material.dart';
import '../dummyCategories.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meals"),
        ),
        body: GridView(
            padding: EdgeInsets.all(25),
            children: DUMMY_CATEGORIES
                .map((catData) => CategoryItem(
                      id: catData.id,
                      title: catData.title,
                      color: catData.color,
                    ))
                .toList(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20)));
  }
}

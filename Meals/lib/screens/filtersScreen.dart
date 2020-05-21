import 'package:Meals/widgets/mainDrawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  final Function saveFilters;

  const FiltersScreen({Key key, this.saveFilters}) : super(key: key);
  static const String routeName = 'filtersScreen.3';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFree = false;
  var _isVegetarian = false;
  var _isVegan = false;
  var _isLactoseFree = false;

  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(description),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Filters"),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final selectedFilter = {
                    'gluten': _isGlutenFree,
                    'lactose': _isLactoseFree,
                    'vegan': _isVegan,
                    'vegetarian': _isVegetarian
                  };
                  widget.saveFilters(selectedFilter);
                })
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.all(20),
                child: Text('Adjust your meal selection',
                    style: Theme.of(context).textTheme.title)),
            Expanded(
                child: ListView(
              children: [
                buildSwitchListTile(
                    "Gluten-free",
                    "Only include gluten free meals",
                    _isGlutenFree, (newValue) {
                  setState(() {
                    _isGlutenFree = newValue;
                  });
                }),
                buildSwitchListTile(
                    "Lactose-free",
                    "Only include lactose free meals",
                    _isLactoseFree, (newValue) {
                  setState(() {
                    _isLactoseFree = newValue;
                  });
                }),
                buildSwitchListTile("Vegetarian",
                    "Only include vegetarian meals", _isVegetarian, (newValue) {
                  setState(() {
                    _isVegetarian = newValue;
                  });
                }),
                buildSwitchListTile(
                    "Vegan", "Only include vegan meals", _isVegan, (newValue) {
                  setState(() {
                    _isVegan = newValue;
                  });
                })
              ],
            ))
          ],
        ));
  }
}

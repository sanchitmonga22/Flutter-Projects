import 'package:Shopping/providers/cart.dart';
import 'package:Shopping/providers/product.dart';
import 'package:Shopping/widgets/appDrawer.dart';
import 'package:Shopping/widgets/badge.dart';
import 'package:Shopping/widgets/productGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartScreen.dart';

enum FilterOpions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final List<Product> loadedProducts = [];
  var showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOpions selectedValue) {
              setState(() {
                if (selectedValue == FilterOpions.Favorites) {
                  showOnlyFavorites = true;
                } else {
                  showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Only favorites"),
                value: FilterOpions.Favorites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOpions.All,
              )
            ],
          ),
          Consumer<Cart>(
              builder: (context, cartData, ch) =>
                  Badge(child: ch, value: cartData.itemsCount.toString()),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ))
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(showFavs: showOnlyFavorites),
    );
  }
}

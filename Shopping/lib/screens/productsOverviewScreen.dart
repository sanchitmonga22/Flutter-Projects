import 'package:Shopping/providers/cart.dart';
import 'package:Shopping/providers/product.dart';
import 'package:Shopping/providers/productsProvider.dart';
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
  bool isInit = true;
  bool isLoading = false;

  @override
  void initState() {
    // this is one of the ways by which you can fetch but there is another way
    //Provider.of<ProductsProvider>(context, listen: false).fetchAndSetProducts();

    // or you can use this code , there is one more way
    // Future.delayed(Duration.zero).then((value) {
    //   Provider.of<ProductsProvider>(context).fetchAndSetProducts();
    // });

    // Future.delayed would work for everyone

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      isLoading = true;
      Provider.of<ProductsProvider>(context)
          .fetchAndSetProducts()
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(showFavs: showOnlyFavorites),
    );
  }
}

import 'package:Shopping/providers/cart.dart';
import 'package:Shopping/providers/orders.dart';
import 'package:Shopping/providers/productsProvider.dart';
import 'package:Shopping/screens/cartScreen.dart';
import 'package:Shopping/screens/editProductScreen.dart';
import 'package:Shopping/screens/ordersScreen.dart';
import 'package:Shopping/screens/productDetailScreen.dart';
import 'package:Shopping/screens/productsOverviewScreen.dart';
import 'package:Shopping/screens/userProductsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          EditProductScreen.routeName: (context) => EditProductScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        },
      ),
    );
  }
}

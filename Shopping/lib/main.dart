import 'package:Shopping/helpers/customRoute.dart';
import 'package:Shopping/providers/auth.dart';
import 'package:Shopping/providers/cart.dart';
import 'package:Shopping/providers/orders.dart';
import 'package:Shopping/providers/productsProvider.dart';
import 'package:Shopping/screens/authScreen.dart';
import 'package:Shopping/screens/cartScreen.dart';
import 'package:Shopping/screens/editProductScreen.dart';
import 'package:Shopping/screens/ordersScreen.dart';
import 'package:Shopping/screens/productDetailScreen.dart';
import 'package:Shopping/screens/productsOverviewScreen.dart';
import 'package:Shopping/screens/splashScreen.dart';
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
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, ProductsProvider>(
            update: (context, auth, previousProductProvider) {
              return ProductsProvider(
                  auth.token,
                  (previousProductProvider == null
                      ? []
                      : previousProductProvider.products),
                  auth.userId);
            },
            create: (BuildContext context) {
              return ProductsProvider("", [], "");
            },
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (context, auth, previousOrder) {
              return Orders(
                  auth.token,
                  (previousOrder == null ? [] : previousOrder.orders),
                  auth.userId);
            },
            create: (context) => Orders("", [], ""),
          )
        ],
        child: Consumer<Auth>(
          builder: (context, authData, child) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder()
                })),
            home: authData.isAuth
                ? ProductsOverviewScreen()
                : FutureBuilder(
                    future: authData.tryAutoLogin(),
                    builder: (context, authResultSnapShot) {
                      print("Entered");
                      return authResultSnapShot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen();
                    }),
            routes: {
              EditProductScreen.routeName: (context) => EditProductScreen(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              OrdersScreen.routeName: (context) => OrdersScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            },
          ),
        ));
  }
}

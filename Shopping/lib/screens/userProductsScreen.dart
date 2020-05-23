import 'package:Shopping/providers/productsProvider.dart';
import 'package:Shopping/widgets/appDrawer.dart';
import 'package:Shopping/widgets/userProductItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'editProductScreen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/userProducts';
  const UserProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Your Products"), actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(EditProductScreen.routeName);
          },
        )
      ]),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemBuilder: (context, index) => Column(
                  children: [
                    UserProductItem(
                      title: productsData.items[index].title,
                      imageUrl: productsData.items[index].imageUrl,
                    ),
                    Divider()
                  ],
                ),
            itemCount: productsData.items.length),
      ),
    );
  }
}

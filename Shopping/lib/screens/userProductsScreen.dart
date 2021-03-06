import 'package:Shopping/providers/productsProvider.dart';
import 'package:Shopping/widgets/appDrawer.dart';
import 'package:Shopping/widgets/userProductItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'editProductScreen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/userProducts';
  const UserProductsScreen({Key key}) : super(key: key);

  Future<void> refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: refreshProducts(context),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => refreshProducts(context),
                child: Consumer<ProductsProvider>(
                  builder: (context, productsData, child) => Padding(
                    padding: EdgeInsets.all(8),
                    child: ListView.builder(
                        itemBuilder: (context, index) => Column(
                              children: [
                                UserProductItem(
                                  id: productsData.items[index].id,
                                  title: productsData.items[index].title,
                                  imageUrl: productsData.items[index].imageUrl,
                                ),
                                Divider()
                              ],
                            ),
                        itemCount: productsData.items.length),
                  ),
                ),
              ),
      ),
    );
  }
}

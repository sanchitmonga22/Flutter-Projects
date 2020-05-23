import 'package:Shopping/providers/productsProvider.dart';
import 'package:Shopping/widgets/productItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;

  const ProductGrid({Key key, this.showFavs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          // return ChangeNotifierProvider(
          //     create: (context) => products[index], child: ProductItem()

          // Using .value instead of the create method because
          //it will update all the elements in the list
          return ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(),
            // var currentProduct = products[index];
            // return ProductItem(
            //   id: currentProduct.id,
            //   imageUrl: currentProduct.imageUrl,
            //   title: currentProduct.title,
          );
        });
  }
}

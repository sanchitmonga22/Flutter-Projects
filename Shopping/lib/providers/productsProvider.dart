import 'dart:convert';
import 'package:Shopping/models/httpException.dart';
import 'package:Shopping/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> products = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var showFavoriteOnly = false;

  List<Product> get items {
    // if (showFavoriteOnly) {
    //   return items.where((element) => element.isFavorite).toList();
    // }
    return [...products];
  }

  List<Product> get favoriteItems {
    return products.where((element) => element.isFavorite == true).toList();
  }

  Product findByID(String id) {
    return products.firstWhere((product) => product.id == id);
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutterpractise-a76f3.firebaseio.com/products/$id.json';
    final existingProductIndex = products.indexWhere((prod) => prod.id == id);
    var existingProduct = products[existingProductIndex];
    final response = await http.delete(url);
    products.removeAt(existingProductIndex);
    notifyListeners();
    if (response.statusCode >= 400) {
      products.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProduct = null;
  }

  // void showFavoritesOnly() {
  //   showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   showFavoriteOnly = false;
  //   notifyListeners();
  // }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = products.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://flutterpractise-a76f3.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      products[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print("...");
    }
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://flutterpractise-a76f3.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodID, prodData) {
        loadedProducts.add(Product(
            id: prodID,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
            imageUrl: prodData['imageUrl']));
      });
      products = loadedProducts;
      print(response);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://flutterpractise-a76f3.firebaseio.com/products.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite
          }));
      final newProduct = Product(
          title: product.title,
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price,
          id: json.decode(response.body)['name']);
      products.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}

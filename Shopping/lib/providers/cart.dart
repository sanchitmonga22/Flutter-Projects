import 'dart:core';

import 'package:Shopping/providers/cartItems.dart';
import 'package:flutter/widgets.dart';

class Cart with ChangeNotifier {
  Map<String, CartItems> _items = {};

  Map<String, CartItems> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    print(total);
    return total;
  }

  void addItem(String productID, double price, String title) {
    if (_items.containsKey(productID)) {
      _items.update(productID, (existingCartItem) {
        var item = existingCartItem;
        return CartItems(
          id: item.id,
          title: item.title,
          quantity: (item.quantity + 1),
          price: item.price,
        );
      });
    } else {
      _items.putIfAbsent(
          productID,
          () => CartItems(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeSingleItem(String productID) {
    if (!_items.containsKey(productID)) {
      return;
    }
    if (_items[productID].quantity > 1) {
      _items.update(
          productID,
          (existingCartItem) => CartItems(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price));
    } else {
      _items.remove(productID);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

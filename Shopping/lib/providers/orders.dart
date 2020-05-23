import 'package:Shopping/providers/orderItem.dart';
import 'package:Shopping/widgets/cartItem.dart';
import 'package:flutter/widgets.dart';

import 'cartItems.dart';

class Orders with ChangeNotifier {
  List<OrderItem> orders = [];
  List<OrderItem> get allOrders {}

  void addOrder(List<CartItems> cartProducts, double total) {
    orders.insert(
        0,
        OrderItem(
            amount: total,
            dateTime: DateTime.now(),
            id: DateTime.now().toString(),
            products: cartProducts));
    notifyListeners();
  }
}

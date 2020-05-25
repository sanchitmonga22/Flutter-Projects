import 'dart:convert';
import 'package:Shopping/providers/orderItem.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'cartItems.dart';

class Orders with ChangeNotifier {
  List<OrderItem> orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this.orders, this.userId);

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://flutterpractise-a76f3.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> laodedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      laodedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItems(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'],
                  quantity: item['quantity']))
              .toList()));
    });
    orders = laodedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItems> cartProducts, double total) async {
    final url =
        'https://flutterpractise-a76f3.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cartItem) => {
                    'id': cartItem.id,
                    'title': cartItem.title,
                    'price': cartItem.price,
                    'quantity': cartItem.quantity
                  })
              .toList()
        }));

    orders.insert(
        0,
        OrderItem(
            amount: total,
            dateTime: timeStamp,
            id: json.decode(response.body)['name'],
            products: cartProducts));
    notifyListeners();
  }
}

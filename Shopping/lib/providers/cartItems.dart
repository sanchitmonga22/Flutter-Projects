import 'package:flutter/cupertino.dart';

class CartItems {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItems(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

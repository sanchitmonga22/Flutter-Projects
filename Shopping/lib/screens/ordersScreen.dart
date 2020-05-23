import 'package:Shopping/providers/orders.dart';
import 'package:Shopping/widgets/appDrawer.dart';
import 'package:Shopping/widgets/orderItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '\orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return OrderItemWidget(order: orderData.orders[index]);
          },
          itemCount: orderData.orders.length,
        ));
  }
}

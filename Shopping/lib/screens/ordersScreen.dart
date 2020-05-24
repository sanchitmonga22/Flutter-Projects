import 'package:Shopping/providers/orders.dart';
import 'package:Shopping/widgets/appDrawer.dart';
import 'package:Shopping/widgets/orderItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '\orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.error != null) {
              return Center(child: Text("An error occured"));
            } else {
              return Consumer<Orders>(builder: (context, orderData, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return OrderItemWidget(order: orderData.orders[index]);
                  },
                  itemCount: orderData.orders.length,
                );
              });
            }
          },
        ));
  }
}

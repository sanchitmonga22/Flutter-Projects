import 'package:Planner/widgets/transactionItem.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  "No transactions added yet",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            );
          })
        : ListView(children: [
            ...transactions.map((tx) => TransactionItem(
                key: ValueKey(tx.id),
                transaction: tx,
                deleteTransaction: deleteTransaction))
          ]);

    // : ListView.builder(
    //     itemCount: transactions.length,
    //     itemBuilder: (context, index) {
    //       return TransactionItem(
    //           transaction: transactions[index],
    //           deleteTransaction: deleteTransaction);
    //     },

    // return Card(
    //     child: Row(children: <Widget>[
    //   Container(
    //     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    //     child: Text(
    //       '\$${transactions[index].amount.toStringAsFixed(2)}',
    //       style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 20,
    //           color: Theme.of(context).primaryColor),
    //     ),
    //     decoration: BoxDecoration(
    //         border: Border.all(
    //             color: Theme.of(context).primaryColor, width: 2)),
    //     padding: EdgeInsets.all(10),
    //   ),
    //   Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Text(
    //         transactions[index].title,
    //         style: Theme.of(context).textTheme.title,
    //       ),
    //       Text(
    //           DateFormat("yyyy-MM-dd")
    //               .format(transactions[index].date),
    //           style: TextStyle(
    //               color: Theme.of(context).primaryColorDark))
    //     ],
    //   )
    // ]));
  }
}

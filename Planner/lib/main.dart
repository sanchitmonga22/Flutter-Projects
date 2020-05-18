import 'package:Planner/widgets/chart.dart';
import 'package:Planner/widgets/newTransaction.dart';
import 'package:Planner/widgets/transactionList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/transaction.dart';

void main() {
  // To lock the application in a particular mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses planner',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //     id: "t1", title: "New Shoes", amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: "t2", title: "Weekly Grocery", amount: 89.99, date: DateTime.now())
  ];
  bool showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        amount: amount,
        title: title,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startAddNewTransactions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startAddNewTransactions(context);
          },
        )
      ],
      title: Text(
        'Expenses Planner',
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart'),
                Switch(
                  value: showChart,
                  onChanged: (val) {
                    setState(() {
                      showChart = val;
                    });
                  },
                ),
              ],
            ),
            showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(_recentTransactions))
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            -MediaQuery.of(context).padding.top -
                            appBar.preferredSize.height) *
                        0.60,
                    child: TransactionList(_transactions, deleteTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransactions(context);
        },
      ),
    );
  }
}

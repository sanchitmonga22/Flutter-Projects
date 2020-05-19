import 'package:flutter/material.dart';
import 'dummyWidget.dart';

void main() {
  runApp(Practise());
}

class Practise extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PractiseAppState();
  }
}

class _PractiseAppState extends State<Practise> {
  String message = "Yo, What\'s up";

  void changeText() {
    setState(() {
      message = "I am still learning";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Practise"),
            ),
            body: DummyWidget(message, changeText)));
  }
}

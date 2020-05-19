import 'package:flutter/material.dart';

class DummyWidget extends StatelessWidget {
  final String message;
  final Function resetText;
  DummyWidget(this.message, this.resetText);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(message),
        FlatButton(
          child: Text("Change Text"),
          onPressed: resetText,
          textColor: Colors.blue,
        )
      ],
    ));
  }
}

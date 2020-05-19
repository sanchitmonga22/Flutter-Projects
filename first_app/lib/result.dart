import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetQuiz;
  Result(this.resultScore, this.resetQuiz);

  String get resultPhrase {
    String resultText;
    print(resultScore);
    if (resultScore >= 50) {
      resultText = "You are awesome!";
    } else if (resultScore <= 30) {
      resultText = 'Pretty likeable!';
    } else {
      resultText = "You are so bad!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(
          resultPhrase,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          child: Text('Restart Quiz!'),
          onPressed: resetQuiz,
          textColor: Colors.blue,
        ),
      ],
    ));
  }
}

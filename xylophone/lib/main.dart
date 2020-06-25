import 'package:flutter/material.dart';
import "package:audioplayers/audio_cache.dart";

void main() {
  runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({Key key}) : super(key: key);

  void playSound(int soundNumber) {
    final player = AudioCache();
    player.play('note$soundNumber.wav');
  }

  @override
  Widget build(BuildContext context) {
    const colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.lightGreen,
      Colors.green,
      Colors.blue,
      Colors.purple
    ];

    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: colors.length,
                itemBuilder: (_, index) {
                  return FlatButton(
                    padding: EdgeInsets.all(58.6),
                    color: colors[index],
                    onPressed: () {
                      playSound(index + 1);
                    },
                  );
                }),
          ),
        ],
      )),
    ));
  }
}

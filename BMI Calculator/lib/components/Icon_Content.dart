import 'package:flutter/material.dart';
import '../constants.dart';

class IconContent extends StatelessWidget {
  final String text;
  final IconData icon;
  const IconContent({Key key, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80,
        ),
        SizedBox(height: 15),
        Text(
          text,
          style: klabelTextStyle,
        )
      ],
    );
  }
}

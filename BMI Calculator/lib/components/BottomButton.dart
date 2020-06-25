import 'package:flutter/material.dart';

import '../constants.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final Function onTap;
  const BottomButton({
    this.text,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(child: Text(text, style: kLargeButtonTextStyle)),
        color: kbottomContainerColor,
        padding: EdgeInsets.only(bottom: 10),
        margin: EdgeInsets.only(top: 10),
        width: double.infinity,
        height: kbottomContainerHeight,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../constants.dart';

class PayText extends StatelessWidget {
  final String text;

  PayText({
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kBody2TextStyle.copyWith(
        fontSize: 18,
      ),
    );
  }
}

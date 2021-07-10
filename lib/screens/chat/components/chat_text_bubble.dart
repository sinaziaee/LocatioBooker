import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChatTextBubble extends StatelessWidget {
  final String text, time;

  ChatTextBubble({
    this.time,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(text ?? ''),
        Text(
          time ?? '',
          style: kBody3TextStyle.copyWith(),
        ),
      ],
    );
  }
}

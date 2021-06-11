import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChatBody extends StatelessWidget {
  final String text, time;
  final bool isMe;

  ChatBody({this.isMe, this.text, this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(text),
        Text(
          time,
          style: kBody3TextStyle.copyWith(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChatFileBubble extends StatelessWidget {
  final String fileLast, url, time;

  ChatFileBubble({
    this.url,
    this.fileLast,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 100,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Icon(
            Icons.download_rounded,
            color: Colors.blueGrey,
            size: 60,
          ),
        ),
        Text(
          fileLast,
          textAlign: TextAlign.start,
          style: kBody2TextStyle.copyWith(
            color: Colors.black,
          ),
        ),
        Text(
          time,
          style: kBody3TextStyle.copyWith(),
        ),
      ],
    );
  }
}

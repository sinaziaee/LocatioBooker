import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChatFileBubble extends StatelessWidget {
  final String fileLast, url, time, text;

  ChatFileBubble({
    this.url,
    this.fileLast,
    this.time,
    @required this.text,
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
            color: Colors.blueGrey,
          ),
          child: Icon(
            Icons.download_rounded,
            color: Colors.white,
            size: 60,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          fileLast,
          textAlign: TextAlign.start,
          style: kBody2TextStyle.copyWith(
            color: Colors.grey[700],
            fontSize: 13,
          ),
        ),
        Text(
          text,
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

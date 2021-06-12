import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bubble/bubble.dart';
import 'package:loctio_booker/screens/chat/components/chat_body.dart';

import '../../../constants.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String text;
  final String dateTime;
  final Size size;

  ChatBubble({
    this.text,
    this.dateTime,
    this.isMe,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isMe) ...[
          Expanded(
            child: Bubble(
              style: styleMe,
              child: ChatBody(
                text: text,
                time: dateTime.substring(10, 16),
                isFile: false,
                isReplied: false,
              ),
            ),
          ),
        ] else ...[
          Expanded(
            child: Bubble(
              style: styleSomebody,
              child: ChatBody(
                text: text,
                isFile: true,
                isReplied: false,
                time: dateTime.substring(10, 16),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

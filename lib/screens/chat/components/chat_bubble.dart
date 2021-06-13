import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bubble/bubble.dart';
import 'package:loctio_booker/screens/chat/components/chat_body.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../constants.dart';
import 'chat_alert_dialog.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String text;
  final String dateTime;
  final Size size;
  final int textId;
  final Function onSwipe;
  final Function onEditPressed, onDeletePressed, onReplyPressed;

  ChatBubble({
    this.text,
    this.dateTime,
    this.isMe,
    this.size,
    this.textId,
    this.onSwipe,
    this.onDeletePressed,
    this.onEditPressed,
    this.onReplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onLeftSwipe: onSwipe,
      child: Row(
        children: [
          if (isMe) ...[
            Expanded(
              child: Bubble(
                style: styleMe,
                child: InkWell(
                  onTap: () {
                    print(textId);
                    showOnMessageTapped(context);
                  },
                  child: ChatBody(
                    text: text,
                    time: dateTime.substring(10, 16),
                    isFile: false,
                    isReplied: false,
                    size: size,
                    textId: textId,
                  ),
                ),
              ),
            ),
          ] else ...[
            Expanded(
              child: Bubble(
                style: styleSomebody,
                child: InkWell(
                  onTap: () {
                    print(textId);
                    showOnMessageTapped(context);
                  },
                  child: ChatBody(
                    text: text,
                    isFile: false,
                    isReplied: false,
                    textId: textId,
                    time: dateTime.substring(10, 16),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  showOnMessageTapped(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ChatAlertDialog(
          onDeletePressed: onDeletePressed,
          onEditPressed: onEditPressed,
          onReplyPressed: onReplyPressed,
        );
      },
    );
  }
}


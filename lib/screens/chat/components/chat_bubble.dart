import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bubble/bubble.dart';
import 'package:loctio_booker/screens/chat/components/chat_body.dart';
import 'package:loctio_booker/screens/chat/models/message.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../constants.dart';
import 'chat_alert_dialog.dart';

class ChatBubble extends StatelessWidget {
  final Size size;
  final Message message;
  final Function onSwipe;
  final Function(Message) onMessageTapped;

  ChatBubble({
    this.message,
    this.size,
    this.onSwipe,
    this.onMessageTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onLeftSwipe: onSwipe,
      child: Row(
        children: [
          if (message.isMe) ...[
            Expanded(
              child: Bubble(
                style: styleMe,
                child: InkWell(
                    onTap: (){
                      onMessageTapped(message);
                    },
                  child: ChatBody(
                    isFile: false,
                    isReplied: message.repliedMessageId != null,
                    size: size,
                    message: message,
                  ),
                ),
              ),
            ),
          ] else ...[
            Expanded(
              child: Bubble(
                style: styleSomebody,
                child: InkWell(
                  onTap: (){
                    onMessageTapped(message);
                  },
                  child: ChatBody(
                    isFile: false,
                    isReplied: message.repliedMessageId != null,
                    message: message,
                    size: size,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:loctio_booker/screens/chat/components/chat_file_bubble.dart';
import 'package:loctio_booker/screens/chat/components/chat_image_bubble.dart';
import 'package:loctio_booker/screens/chat/components/chat_text_bubble.dart';
import 'package:loctio_booker/screens/chat/models/message.dart';

import 'chat_reply_part.dart';

class ChatBody extends StatelessWidget {
  final bool isReplied, isFile;
  String fileLast;
  final Size size;
  Message message;

  ChatBody({
    this.isFile,
    this.isReplied,
    this.message,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showChat(context),
    );
  }

  showChat(BuildContext context) {
    // simple message
    if (!isReplied && !isFile) {
      return ChatTextBubble(
        time: message.dateTime.substring(10, 16),
        text: message.text,
      );
    }
    // simple file
    else if (!isReplied && isFile) {
      return showImageFile(context);
    }
    // replied message
    else if (isReplied && !isFile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ChatReplyPart(
            repliedText: message.repliedMessageText,
            repliedUser: message.repliedMessageUser,
            isMe: message.isMe,
          ),
          ChatTextBubble(
            text: message.text,
            time: message.dateTime.substring(10, 16),
          ),
        ],
      );
    }
    // replied file
    else if (isReplied && isFile) {
      return Column(
        children: [
          ChatReplyPart(
            repliedText: message.repliedMessageText,
            repliedUser: message.repliedMessageUser,
            isMe: message.isMe,
          ),
          showImageFile(context),
        ],
      );
    }
  }

  showImageFile(BuildContext context) {
    // image
    if (message.url.endsWith('.jpg') ||
        message.url.endsWith('.jpeg') ||
        message.url.endsWith('.png')) {
      return ChatImageBubble(
        time: message.dateTime.substring(10, 16),
        fileLast: fileLast,
        url: message.url,
      );
    }
    // file (not image)
    else {
      return ChatFileBubble(
        url: message.url,
        fileLast: fileLast,
        time: message.dateTime.substring(10, 16),
      );
    }
  }
}

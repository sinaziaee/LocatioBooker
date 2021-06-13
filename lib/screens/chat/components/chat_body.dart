import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:loctio_booker/screens/chat/components/chat_file_bubble.dart';
import 'package:loctio_booker/screens/chat/components/chat_image_bubble.dart';
import 'package:loctio_booker/screens/chat/components/chat_text_bubble.dart';
import 'package:loctio_booker/screens/chat/models/message.dart';

import '../../../constants.dart';
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
    if (message.repliedMessageUser == null ||
        message.repliedMessageUser.length == 0) {
      message.repliedMessageUser = 'Sina Ziaee';
    }
    if (message.repliedMessageText == null ||
        message.repliedMessageText.length == 0) {
      message.repliedMessageText =
          'This is the diaria cat So the best thing is like,'
          ' if this is not sth that we do';
      // repliedText = 'This is the diaria';
    }
    if (message.url == null || message.url.length == 0) {
      // url = 'static/temp.file';
      message.url = 'static/temp.jpg';
      fileLast = message.url.split('/').last;
    }

    // return showChat(context);
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

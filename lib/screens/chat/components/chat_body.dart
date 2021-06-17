import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:loctio_booker/constants.dart';
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
    if(isFile){
      fileLast = message.file.split('/').last;
    }
    // print('======================');
    // print(isFile);
    // print('======================');
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
    // print('$mainUrl${message.file}');
    // image
    if (message.file.endsWith('.jpg') ||
        message.file.endsWith('.jpeg') ||
        message.file.endsWith('.png')) {
      return ChatImageBubble(
        time: message.dateTime.substring(10, 16),
        fileLast: fileLast,
        file: message.file,
        text: message.text ?? '',
      );
    }
    // file (not image)
    else {
      return ChatFileBubble(
        url: message.file,
        fileLast: fileLast,
        text: message.text ?? '',
        time: message.dateTime.substring(10, 16),
      );
    }
  }
}

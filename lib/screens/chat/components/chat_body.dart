import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:loctio_booker/screens/chat/components/chat_file_bubble.dart';
import 'package:loctio_booker/screens/chat/components/chat_image_bubble.dart';
import 'package:loctio_booker/screens/chat/components/chat_text_bubble.dart';

import '../../../constants.dart';
import 'chat_reply_part.dart';

class ChatBody extends StatelessWidget {
  final String text, time;
  final bool isReplied, isFile;
  String url;
  String fileLast;
  String repliedText;
  String repliedUser;
  final Size size;

  ChatBody({
    this.text,
    this.time,
    this.isFile,
    this.isReplied,
    this.url,
    this.repliedText,
    this.repliedUser,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (repliedUser == null || repliedUser.length == 0) {
      repliedUser = 'Sina Ziaee';
    }
    if (repliedText == null || repliedText.length == 0) {
      repliedText = 'This is the diaria cat So the best thing is like,'
          ' if this is not sth that we do';
      // repliedText = 'This is the diaria';
    }
    if (url == null || url.length == 0) {
      // url = 'static/temp.file';
      url = 'static/temp.jpg';
      fileLast = url.split('/').last;
    }
    // simple message
    if (!isReplied && !isFile) {
      return ChatTextBubble(
        time: time,
        text: text,
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
            repliedText: repliedText,
            repliedUser: repliedUser,
          ),
          ChatTextBubble(
            text: text,
            time: time,
          ),
        ],
      );
    }
    // replied file
    else if (isReplied && isFile) {
      return Column(
        children: [
          ChatReplyPart(
            repliedText: repliedText,
            repliedUser: repliedUser,
          ),
          showImageFile(context),
        ],
      );
    }
  }

  showImageFile(BuildContext context) {
    // image
    if (url.endsWith('.jpg') || url.endsWith('.jpeg') || url.endsWith('.png')) {
      return ChatImageBubble(
        time: time,
        fileLast: fileLast,
        url: url,
      );
    }
    // file (not image)
    else {
      return ChatFileBubble(
        url: url,
        fileLast: fileLast,
        time: time,
      );
    }
  }
}

import 'package:flutter/material.dart';

import 'chat_dialog_bubble.dart';

class ChatReplyAlertDialog extends StatelessWidget {
  final Function onDeletePressed, onReplyPressed;

  ChatReplyAlertDialog({
    this.onDeletePressed,
    this.onReplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ChatDialogItem(
            text: 'Reply',
            iconData: Icons.reply,
            onTapped: onReplyPressed,
          ),
          ChatDialogItem(
            text: 'Delete',
            iconData: Icons.delete_outline,
            onTapped: onDeletePressed,
          ),
        ],
      ),
    );
  }
}

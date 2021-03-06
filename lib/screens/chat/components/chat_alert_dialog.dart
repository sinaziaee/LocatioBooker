import 'package:flutter/material.dart';

import 'chat_dialog_bubble.dart';

class ChatAlertDialog extends StatelessWidget {
  final Function onEditPressed, onDeletePressed, onReplyPressed;

  ChatAlertDialog({
    this.onDeletePressed,
    this.onEditPressed,
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
          ChatDialogItem(
            text: 'Edit',
            iconData: Icons.edit,
            onTapped: onEditPressed,
          ),
        ],
      ),
    );
  }
}

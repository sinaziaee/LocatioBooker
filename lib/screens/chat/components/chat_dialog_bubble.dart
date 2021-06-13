import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChatDialogItem extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Function onTapped;

  ChatDialogItem({
    this.iconData,
    this.text,
    this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: onTapped,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.blueGrey[700],
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: kBody2TextStyle.copyWith(
                color: Colors.blueGrey[700],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
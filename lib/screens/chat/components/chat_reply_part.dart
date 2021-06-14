import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChatReplyPart extends StatelessWidget {

  final String repliedUser, repliedText;

  ChatReplyPart({this.repliedText, this.repliedUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 28,
              width: 1,
              color: Colors.green,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  repliedUser,
                  style: kBody2TextStyle.copyWith(
                    color: Colors.green,
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Container(
                  // width: size.width - 100,
                  width: 200,
                  child: Text(
                    repliedText,
                    style: kBody2TextStyle.copyWith(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class ChatRoomItem extends StatelessWidget {
  final String imageUrl;
  final String username, lastText, lastDateTime;
  final int chatRoomId;
  final Function onTapped;
  final bool isLast;

  ChatRoomItem({
    this.chatRoomId,
    this.onTapped,
    this.imageUrl,
    this.username,
    this.lastDateTime,
    this.lastText,
    this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.only(
            top: 5,
            bottom: 1,
          ),
          child: ListTile(
            onTap: onTapped,
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 23,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 22,
                backgroundImage: (imageUrl != null)
                    ? NetworkImage(imageUrl)
                    : AssetImage(
                        'assets/images/unknown_person.png',
                      ),
              ),
            ),
            title: Text(
              username ?? 'username',
              // style: kBody2TextStyle.copyWith(),
            ),
            subtitle: Text((lastText != null && lastText.length != 0) ? lastText : ''),
            trailing: Text(
              (lastDateTime != null && lastDateTime.length != 0) ? lastDateTime.substring(0, 16) : 'N/A',
            ),
          ),
        ),
        Visibility(
          // visible: isLast,
          visible: !isLast,
          child: Container(
            height: 0.5,
            color: Colors.grey,
            margin: EdgeInsets.symmetric(
              horizontal: 20,
            ),
          ),
        ),
      ],
    );
  }
}

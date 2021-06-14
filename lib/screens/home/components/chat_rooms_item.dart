import 'package:flutter/material.dart';

class ChatRoomItem extends StatelessWidget {
  final String imageUrl;
  final String username, lastText, lastDateTime;
  final int userId;
  final Function onTapped;

  ChatRoomItem({
    this.userId,
    this.onTapped,
    this.imageUrl,
    this.username,
    this.lastDateTime,
    this.lastText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.only(
        top: 5,
        bottom: 1,
      ),
      child: ListTile(
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
        subtitle: Text(lastText ?? 'last date'),
        trailing: Text(
          (lastDateTime != null) ? lastDateTime.substring(0, 16) : '2020',
        ),
      ),
    );
  }
}

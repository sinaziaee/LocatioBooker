import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/constants.dart';
import 'dart:convert' as convert;

import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/home/components/chat_rooms_item.dart';

class ChatRoomsPage extends StatefulWidget {
  final User user;

  ChatRoomsPage({this.user});

  @override
  _ChatRoomsPageState createState() => _ChatRoomsPageState();
}

class _ChatRoomsPageState extends State<ChatRoomsPage> {
  Size size;
  String url = '$mainUrl/api/';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      child: FutureBuilder(
        future: getChatRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return itemBuilder();
                },
              ),
            );
          } else {
            return ChatRoomItem();
            return Center(
              child: kMyProgressIndicator,
            );
          }
        },
      ),
    );
  }

  Widget itemBuilder(
      {String imageUrl, String username, int userId, Function onTapped, String lastDateTime, String lastText}) {
    return ChatRoomItem(
      onTapped: onTapped,
      imageUrl: imageUrl,
      userId: userId,
      username: username,
      lastDateTime: lastDateTime,
      lastText: lastText,
    );
  }

  Future<http.Response> getChatRooms() async {
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
      },
    );
    return response;
  }
}

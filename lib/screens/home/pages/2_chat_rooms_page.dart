import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/constants.dart';
import 'dart:convert' as convert;

import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/chat/chat_screen.dart';
import 'package:loctio_booker/screens/home/components/chat_rooms_item.dart';
import 'package:loctio_booker/screens/hosting/components/nothing_found.dart';

class ChatRoomsPage extends StatefulWidget {
  final User user;

  ChatRoomsPage({this.user});

  @override
  _ChatRoomsPageState createState() => _ChatRoomsPageState();
}

class _ChatRoomsPageState extends State<ChatRoomsPage> {
  Size size;
  String url = '$mainUrl/api/chat/show/';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: FutureBuilder(
        future: getChatRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            http.Response response = snapshot.data;
            print('---------------------------');
            print(response.body);
            if (response.statusCode < 400) {
              var jsonResponse =
                  convert.json.decode(convert.utf8.decode(response.bodyBytes));
              Map result = jsonResponse;
              List list = result['data'];
              if (list.length == 0) {
                return Center(
                  child: NothingFound(
                    size: size,
                    text1: '',
                    text2: 'No Chat found',
                    image: 'assets/images/img-not-found.png',
                  ),
                );
              }
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  Map item = list[index];
                  return ChatRoomItem(
                    onTapped: () {
                      onChatRoomPressed(
                        chatRoomId: item['chat_id'],
                        otherUser: '${item['first_name']} ${item['last_name']}',
                        otherUserImageUrl: item['image'],
                      );
                    },
                    imageUrl: item['image'],
                    chatRoomId: item['chat_id'],
                    username: '${item['first_name']} ${item['last_name']}',
                    lastDateTime: item['last_message'] != null
                        ? item['last_message']['ctime']
                        : '',
                    lastText: item['last_message'] != null
                        ? item['last_message']['text']
                        : '',
                    isLast: index == list.length - 1,
                  );
                },
              );
            } //
            else {
              return Center(
                child: Text('An error getting list of chat rooms'),
              );
            }
          } else {
            return Center(
              child: kMyProgressIndicator,
            );
          }
        },
      ),
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

  void onChatRoomPressed(
      {int chatRoomId, String otherUser, String otherUserImageUrl}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ChatScreen(
            user: widget.user,
            chatRoomId: chatRoomId,
            otherUser: otherUser,
            otherUserImageUrl: otherUserImageUrl,
          );
        },
      ),
    );
  }
}

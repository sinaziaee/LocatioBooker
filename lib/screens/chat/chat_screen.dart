import 'package:loctio_booker/screens/chat/components/chat_message_text_field.dart';
import 'package:loctio_booker/static_methods.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'components/message_bubbles.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  ChatScreen();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    // Uri.parse('wss://echo.websocket.org'),
    Uri.parse('ws://192.168.43.126:8000/ws/api/chat/1/'),
  );
  FocusNode focusNode;
  String imageUrl = '', name;
  Size size;

  @override
  Widget build(BuildContext context) {
    focusNode = FocusScope.of(context);
    name = name ?? 'sina ziaee';
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.chatAppbar(context, imageUrl, name),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MessageBubbles(),
          ChatMessageTextField(
            node: focusNode,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    print('sent');
    Map map = Map();
    map['type'] = 'fetch_a';
    map['message'] = 'This is test';
    map['user'] = 'sina';
    // map['chatroom_id'] = 'test';
    // map['type'] = 'create_message';
    var json = convert.json.encode(map);
    _channel.sink.add(json);
    // if (_controller.text.isNotEmpty) {
    //   // _channel.sink.add(_controller.text);
    //   // _channel.sink.add(_controller.text);
    //   _channel.sink.add(json);
    // }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

// StreamBuilder(
// stream: _channel.stream,
// builder: (context, snapshot) {
// return Text(snapshot.hasData ? '${snapshot.data}' : '');
// },
// )

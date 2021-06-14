import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert' as convert;

class TempChatScreen extends StatefulWidget {
  @override
  _TempChatScreenState createState() => _TempChatScreenState();
}

class _TempChatScreenState extends State<TempChatScreen> {
  String socketUrl = 'ws://192.168.43.126:8000/ws/api/chat/1/';
  WebSocketChannel channel;

  @override
  void initState() {
    channel = IOWebSocketChannel.connect(socketUrl);
    connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              channel.sink.add(
                convert.json.encode({'type': 'fetch'}),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            return ListView(
              children: [
                Text('well'),
              ],
            );
          },
        ),
      ),
    );
  }

  connect() {
    print('here');
    // channel.sink.add({'type': 'fetch'});
  }
}

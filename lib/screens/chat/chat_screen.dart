import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:loctio_booker/screens/chat/components/chat_message_text_field.dart';
import 'package:loctio_booker/static_methods.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'components/message_bubbles.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  String socketUrl = 'ws://192.168.43.126:8000/ws/api/chat/1/';
  ChatScreen();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  WebSocketChannel channel;
  FocusNode focusNode;
  String imageUrl = '', name;
  Size size;
  File file;

  String repliedUser, repliedText;
  int repliedTextId;

  @override
  Widget build(BuildContext context) {
    channel = WebSocketChannel.connect(
      // Uri.parse('wss://echo.websocket.org'),
      Uri.parse(widget.socketUrl),
    );
    focusNode = FocusScope.of(context);
    name = name ?? 'sina ziaee';
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.chatAppbar(context, imageUrl, name),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MessageBubbles(
            size: size,
            onSwipe: (id, text, user) {
              onSwiped(id, text, user);
            },
            channel: channel,
          ),
          ChatMessageTextField(
            node: focusNode,
            repliedText: repliedText,
            repliedUser: repliedUser,
            repliedTextId: repliedTextId,
            channel: channel,
            onClearPressed: (){
              onClearPressed();
            },
            onFileSelectorPressed: (){
              showFileSelector();
            },
          ),
        ],
      ),
    );
  }

  void showFileSelector() async{
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path);
      print(result.files.single.path.split('/').last);
      setState(() {});
    } else {
      // User canceled the picker
    }
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
    channel.sink.add(json);
    // if (_controller.text.isNotEmpty) {
    //   // _channel.sink.add(_controller.text);
    //   // _channel.sink.add(_controller.text);
    //   _channel.sink.add(json);
    // }
  }

  onSwiped(int textId, String text, String user) {
    print(textId);
    repliedTextId = textId;
    repliedText = text;
    repliedUser = user;
    setState(() {});
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  onClearPressed(){
    repliedTextId = null;
    repliedText = null;
    repliedUser = null;
    setState(() {});
  }

  void cleaner(){
    file = null;
    onClearPressed();
  }

}

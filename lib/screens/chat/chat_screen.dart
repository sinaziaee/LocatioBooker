import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:loctio_booker/screens/chat/components/chat_message_text_field.dart';
import 'package:loctio_booker/static_methods.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import '../../models/user.dart';
import 'components/message_bubbles.dart';
import 'models/message.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  final User user;
  final int chatRoomId;
  final String otherUser;
  final String otherUserImageUrl;

  ChatScreen({
    @required this.user,
    @required this.chatRoomId,
    @required this.otherUser,
    @required this.otherUserImageUrl,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String socketUrl = 'ws://192.168.43.126:8000/ws/api/chat';
  final TextEditingController chatController = TextEditingController();
  WebSocketChannel channel;
  FocusNode focusNode;
  Size size;
  ScrollController chatScrollController = ScrollController();
  File file;
  bool isEditing = false;
  String repliedUser, repliedText;
  int repliedTextId;
  Message messageToEdit;

  @override
  Widget build(BuildContext context) {
    focusNode = FocusScope.of(context);
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.chatAppbar(
          context, widget.otherUserImageUrl, widget.otherUser),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MessageBubbles(
            chatScrollController: chatScrollController,
            size: size,
            onSwipe: (id, text, user) {
              onSwiped(id, text, user);
            },
            scrollToBottom: (){
              scrollToBottom();
            },
            fetcher: (){
              fetcher();
            },
            changeEditingToFalse: (){
              changeEditToFalse();
            },
            channel: channel,
            otherUserImageUrl: widget.otherUserImageUrl,
            otherUser: widget.otherUser,
            chatRoomId: widget.chatRoomId,
            user: widget.user,
            chatController: chatController,
            isEditing: isEditing,
            messageToEdit: messageToEdit,
            changeEditingToTrue: (){
              changeEditToTrue();
            },
            onEditPressed: (message){
              onEditPressed(message);
            },
            onRepliedPressed: (id, text, user) {
              onRepliedInDialogPressed(id, text, user);
            },
          ),
          ChatMessageTextField(
            node: focusNode,
            repliedText: repliedText,
            repliedUser: repliedUser,
            repliedTextId: repliedTextId,
            channel: channel,
            scrollToBottom: (){
              scrollToBottom();
            },
            onClearPressed: () {
              cleaner();
            },
            chatController: chatController,
            onFileSelectorPressed: () {
              showFileSelector();
            },
            fetcher: (){
              fetcher();
            },
            changeEditingToFalse: (){
              changeEditToFalse();
            },
            isEditing: isEditing,
            messageToEdit: messageToEdit,
          ),
        ],
      ),
    );
  }

  void showFileSelector() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path);
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  onSwiped(int textId, String text, String user) {
    repliedTextId = textId;
    repliedText = text;
    repliedUser = user;
    changeEditToFalse();
    setState(() {});
  }

  onRepliedInDialogPressed(int textId, String text, String user) {
    repliedTextId = textId;
    repliedText = text;
    repliedUser = user;
    changeEditToFalse();
    Navigator.pop(context);
    setState(() {});
  }

  @override
  void initState() {
    socketUrl = '$socketUrl/${widget.chatRoomId}/';
    channel = WebSocketChannel.connect(
      Uri.parse(socketUrl),
    );
    onChatConnected();
    super.initState();
  }

  onChatConnected() {
    // trying to authorize user
    channel.sink.add(
      convert.json.encode(
        {
          'Authorization': widget.user.token.replaceAll('Token ', ''),
          'type': 'authenticate',
        },
      ),
    );
    // fetching all messages
    fetcher();
  }

  onClearPressed() {
    repliedTextId = null;
    repliedText = null;
    repliedUser = null;
    changeEditToFalse();
    setState(() {});
  }

  void cleaner() {
    file = null;
    onClearPressed();
  }

  scrollToBottom() {
    chatScrollController.jumpTo(chatScrollController.position.minScrollExtent);
  }

  onEditPressed(Message message) {
    cleaner();
    changeEditToTrue();
    chatController.text = message.text;
    repliedText = message.text ;
    repliedUser = message.currentUsername;
    messageToEdit = message;
    print('============================');
    print(messageToEdit.textId);
    Navigator.pop(context);
  }

  fetcher(){
    channel.sink.add(
      convert.json.encode(
        {
          'type': 'fetch',
        },
      ),
    );
  }

  changeEditToTrue(){
    isEditing = true;
  }

  changeEditToFalse(){
    isEditing = false;
  }

}

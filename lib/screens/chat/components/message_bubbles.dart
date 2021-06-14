import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/screens/chat/components/chat_bubble.dart';
import 'package:loctio_booker/screens/chat/models/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert' as convert;
import '../../../models/user.dart';
import 'chat_alert_dialog.dart';

class MessageBubbles extends StatefulWidget {
  final Size size;
  final Function(int id, String text, String user) onSwipe;
  final WebSocketChannel channel;
  final int chatRoomId;
  final String otherUser;
  final String otherUserImageUrl;
  final User user;
  final ScrollController chatScrollController;
  final Function scrollToBottom;
  final Function fetcher, changeEditingToTrue;
  final TextEditingController chatController;
  final bool isEditing;
  Message messageToEdit;

  MessageBubbles({
    this.size,
    this.onSwipe,
    this.channel,
    this.otherUserImageUrl,
    this.otherUser,
    this.chatRoomId,
    this.fetcher,
    this.user,
    this.chatScrollController,
    this.scrollToBottom,
    this.chatController,
    this.isEditing,
    this.messageToEdit,
    this.changeEditingToTrue,
  });

  @override
  _MessageBubblesState createState() => _MessageBubblesState();
}

class _MessageBubblesState extends State<MessageBubbles> {

  @override
  Widget build(BuildContext context) {
    // scrollToBottom();
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpeg'),
            fit: BoxFit.cover,
          ),
          color: Colors.grey[400],
        ),
        padding: EdgeInsets.only(bottom: 3),
        child: StreamBuilder(
          stream: widget.channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              try{
                var jsonResponse = convert.json.decode(snapshot.data);
                List mapList = jsonResponse['data'];
                List<Message> messageList = [];
                for (int i = 0; i < mapList.length; i++) {
                  messageList.add(
                    Message(
                      textId: mapList[i]['message_id'],
                      dateTime: mapList[i]['ctime'],
                      text: mapList[i]['text'],
                      repliedMessageText: mapList[i]['parent_message'].toString(),
                      url: widget.otherUserImageUrl,
                      chatRoomId: widget.chatRoomId,
                      isMe: mapList[i]['owner'] == widget.user.userId,
                      currentUsername: mapList[i]['owner'] == widget.user.userId
                          ? '${widget.user.firstName} ${widget.user.lastName}'
                          : widget.otherUser,
                    ),
                  );
                }
                if (messageList.length == 0) {
                  return Center();
                }
                return listBody(messageList);
              }
              catch(e){
                return Center(
                  child: kMyProgressIndicator,
                );
              }
            } //
            else if (snapshot.hasError) {
              return Center(
                child: kMyProgressIndicator,
              );
            }
            // snapshot without value
            else {
              return Center(
                child: kMyProgressIndicator,
              );
            }
          },
        ),
      ),
    );
  }

  listBody(List<Message> list) {
    return ListView.builder(
      controller: widget.chatScrollController,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ChatBubble(
          message: list[index],
          size: widget.size,
          onMessageTapped: (message) {
            showOnMessageTapped(message);
          },
          onSwipe: () {
            widget.onSwipe(
              list[index].textId,
              list[index].text,
              list[index].currentUsername,
            );
          },
        );
      },
    );
  }

  onDeletePressed(Message message) {
    widget.channel.sink.add(
      convert.json.encode(
        {
          'type': 'delete',
          'message': message.text,
          'message_id': message.textId,
        },
      ),
    );
    widget.fetcher();
    Navigator.pop(context);
  }

  onEditPressed(Message message) {
    widget.changeEditingToTrue();
    widget.chatController.text = message.text;
    widget.messageToEdit = message;
    // widget.channel.sink.add(
    //   convert.json.encode(
    //     {
    //       'type': 'edit',
    //       'message': message.text,
    //       'message_id': message.textId,
    //     },
    //   ),
    // );
    // widget.fetcher();
    Navigator.pop(context);
  }

  onReplyPressed(Message message) {
    Navigator.pop(context);
  }

  showOnMessageTapped(Message message) {
    showDialog(
      context: context,
      builder: (context) {
        return ChatAlertDialog(
          onDeletePressed: () {
            onDeletePressed(message);
          },
          onEditPressed: () {
            onEditPressed(message);
          },
          onReplyPressed: () {
            onReplyPressed(message);
          },
        );
      },
    );
  }
}

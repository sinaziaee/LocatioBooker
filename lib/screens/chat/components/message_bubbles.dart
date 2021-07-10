import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/screens/chat/components/chat_bubble.dart';
import 'package:loctio_booker/screens/chat/models/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert' as convert;
import '../../../models/user.dart';
import 'chat_alert_dialog.dart';
import 'chat_reply_alert_dialog.dart';

class MessageBubbles extends StatefulWidget {
  final Size size;
  final Function(int id, String text, String user) onSwipe;
  final Function(int id, String text, String user) onRepliedPressed;
  final WebSocketChannel channel;
  final int chatRoomId;
  final String otherUser;
  final String otherUserImageUrl;
  final User user;
  final ScrollController chatScrollController;
  final Function scrollToBottom;
  final Function fetcher, changeEditingToTrue, changeEditingToFalse;
  final TextEditingController chatController;
  final bool isEditing;
  Message messageToEdit;
  final Function(Message message) onEditPressed;

  MessageBubbles({
    this.size,
    this.onSwipe,
    this.channel,
    this.changeEditingToFalse,
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
    this.onEditPressed,
    this.onRepliedPressed,
  });

  @override
  _MessageBubblesState createState() => _MessageBubblesState();
}

class _MessageBubblesState extends State<MessageBubbles> {
  List<Message> messageList = [];
  ScrollController chatController = ScrollController();

  @override
  Widget build(BuildContext context) {
    widget.scrollToBottom();
    // jumpToButton();
    return Container(
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
          // print('----------------------------------------');
          // print(snapshot.data);
          // print('----------------------------------------');
          if (snapshot.hasData) {
            try {
              var jsonResponse = convert.json.decode(snapshot.data);
              // print('----------------------------------------');
              // print(jsonResponse['type']);
              // print('----------------------------------------');
              List mapList = jsonResponse['data'];
              messageList = [];
              for (int i = 0; i < mapList.length; i++) {
                messageList.add(
                  Message(
                    textId: mapList[i]['message_id'],
                    dateTime: mapList[i]['ctime'],
                    text: mapList[i]['text'],
                    repliedMessageId: mapList[i]['parent_message'],
                    chatRoomId: widget.chatRoomId,
                    isMe: mapList[i]['owner'] == widget.user.userId,
                    currentUsername: mapList[i]['owner'] == widget.user.userId
                        ? '${widget.user.firstName} ${widget.user.lastName}'
                        : widget.otherUser,
                    file: mapList[i]['file'],
                  ),
                );
              }
              searchOnMessages();
              if (messageList.length == 0) {
                return Center();
              }
              return listBody(messageList);
            } catch (e) {
              // print("============================");
              // print(e);
              widget.fetcher();
              // return Center(
              //   child: kMyProgressIndicator,
              // );
              return Container();
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
    );
  }

  searchOnMessages() {
    for (int i = 0; i < messageList.length; i++) {
      if (messageList[i].repliedMessageId != null) {
        int index = messageList[i].repliedMessageId;
        // print(messageList[i].repliedMessageUser);
        Message message = getSearchedMessage(index);
        // print('found');
        messageList[i].repliedMessageText = message.text;
        messageList[i].repliedMessageId = message.textId;
        messageList[i].repliedMessageUser = message.currentUsername;
        // print(messageList[i].repliedMessageUser);
      }
    }
  }

  Message getSearchedMessage(int indexToSearch) {
    for (int i = 0; i < messageList.length; i++) {
      if (messageList[i].textId == indexToSearch) {
        Message message = messageList[i];
        return message;
      }
    }
    return null;
  }

  listBody(List<Message> list) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   print(timeStamp.inMilliseconds);
    // });
    // widget.scrollToBottom();
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: widget.chatScrollController,
      // controller: chatController,
      // physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      // shrinkWrap: true,
      // reverse: true,
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
    widget.changeEditingToFalse();
    // widget.fetcher();
    Navigator.pop(context);
  }

  showOnMessageTapped(Message message) {
    if (message.isMe) {
      showDialog(
        context: context,
        builder: (context) {
          return ChatAlertDialog(
            onDeletePressed: () {
              onDeletePressed(message);
            },
            onEditPressed: () {
              widget.onEditPressed(message);
            },
            onReplyPressed: () {
              widget.onRepliedPressed(
                message.textId,
                message.text,
                message.currentUsername,
              );
            },
          );
        },
      );
    } //
    else {
      showDialog(
        context: context,
        builder: (context) {
          return ChatReplyAlertDialog(
            onDeletePressed: () {
              onDeletePressed(message);
            },
            onReplyPressed: () {
              widget.onRepliedPressed(
                message.textId,
                message.text,
                message.currentUsername,
              );
            },
          );
        },
      );
    }
  }

  void jumpToButton() {
    // widget.chatScrollController.
    chatController.jumpTo(chatController.position.maxScrollExtent);
    // Timer(Duration(seconds: 1), () {
    //   chatController.jumpTo(chatController.position.maxScrollExtent);
    // });
  }
}

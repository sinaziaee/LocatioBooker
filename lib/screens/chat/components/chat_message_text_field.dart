import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/screens/chat/models/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert' as convert;

class ChatMessageTextField extends StatefulWidget {
  // final FocusNode node;
  final String repliedUser, repliedText;
  final int repliedTextId;
  final Function onClearPressed, onFileSelectorPressed;
  final WebSocketChannel channel;
  final Function scrollToBottom, fetcher, changeEditingToFalse;
  final TextEditingController chatController;
  final bool isEditing;
  final Message messageToEdit;

  ChatMessageTextField({
    // this.node,
    this.repliedText,
    this.repliedUser,
    this.repliedTextId,
    this.onClearPressed,
    this.channel,
    this.onFileSelectorPressed,
    this.scrollToBottom,
    this.chatController,
    this.isEditing,
    this.fetcher,
    this.messageToEdit,
    this.changeEditingToFalse,
  });

  @override
  _ChatMessageTextFieldState createState() => _ChatMessageTextFieldState();
}

class _ChatMessageTextFieldState extends State<ChatMessageTextField> {
  double heightFromBottom = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible:
          (widget.repliedText != null && widget.repliedText.length != 0) || widget.isEditing,
          child: Container(
            height: 50,
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Transform.rotate(
                    angle: 3.05,
                    child: Icon(
                      widget.isEditing
                          ? FontAwesomeIcons.edit
                          : FontAwesomeIcons.reply,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.repliedUser ?? '',
                          style: kBody2TextStyle.copyWith(
                            color: Colors.blueGrey[800],
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Container(
                          child: Text(
                            widget.repliedText ?? '',
                            style: kBody2TextStyle.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onClearPressed,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.repliedText != null,
          child: Container(
            height: 0.3,
            color: Colors.black,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: widget.onFileSelectorPressed,
                  icon: Icon(
                    Icons.attach_file,
                    color: Colors.grey[600],
                  ),
                  iconSize: 20,
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: TextField(
                  cursorColor: Colors.blueGrey,
                  controller: widget.chatController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.only(
                      bottom: 5,
                      top: 5,
                    ),
                    hintText: 'Message',
                    hintStyle: kBody2TextStyle.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  // focusNode: widget.node,
                  maxLines: 6,
                  minLines: 1,
                  style: kBody1TextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    sendMessage();
                    // widget.node.unfocus();
                  },
                  iconSize: 20,
                  icon: Transform.rotate(
                    angle: -0.5,
                    child: Icon(
                      Icons.send,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void sendMessage() {
    // new message
    if (!widget.isEditing) {
      Map map = Map();
      map['type'] = 'create';
      map['message'] = widget.chatController.text;
      // print(widget.repliedText);
      // print(widget.repliedTextId);
      if (widget.repliedText != null) {
        map['parent_message'] = widget.repliedTextId;
      }
      var json = convert.json.encode(map);
      widget.channel.sink.add(json);
    } // editing message
    else {
      // print('************************************');
      // print(widget.chatController.text);
      widget.channel.sink.add(
        convert.json.encode(
          {
            'type': 'update',
            'text': widget.chatController.text,
            'message_id': widget.messageToEdit.textId,
          },
        ),
      );
    }
    widget.changeEditingToFalse();
    widget.chatController.clear();
    widget.onClearPressed();
    // widget.fetcher();
  }
}

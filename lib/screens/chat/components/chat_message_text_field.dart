import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';

class ChatMessageTextField extends StatefulWidget {

  final FocusNode node;

  ChatMessageTextField({this.node});

  @override
  _ChatMessageTextFieldState createState() => _ChatMessageTextFieldState();
}

class _ChatMessageTextFieldState extends State<ChatMessageTextField> {
  TextEditingController chatController = TextEditingController();
  double heightFromBottom = 4;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.attach_file,
                  color: Colors.grey[600],
                ),
                iconSize: 20,
              ),
              SizedBox(
                height: heightFromBottom,
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: TextField(
                controller: chatController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Message'
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
                  widget.node.unfocus();
                },
                iconSize: 20,
                icon: Icon(
                  Icons.send,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(
                height: heightFromBottom,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

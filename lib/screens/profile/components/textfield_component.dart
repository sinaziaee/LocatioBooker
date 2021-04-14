import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final bool status;
  final String hintText;
  final TextEditingController controller;
  final bool isReadOnly;

  TextFieldComponent({this.status, this.hintText, this.controller, this.isReadOnly});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
              ),
              readOnly: isReadOnly ?? false,
              enabled: !status,
              autofocus: !status,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}

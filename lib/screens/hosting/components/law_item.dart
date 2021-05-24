import 'package:flutter/material.dart';

import '../../../constants.dart';

class LawItem extends StatefulWidget {
  String text;
  // bool state;
  List list;
  int index;
  LawItem({this.list, this.text, this.index});

  @override
  _LawItemState createState() => _LawItemState();
}

class _LawItemState extends State<LawItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: (){
          setState(() {
            // widget.state = !widget.state;
            widget.list[widget.index] = !widget.list[widget.index];
          });
        },
        leading: Checkbox(
          activeColor: Colors.blueGrey[800],
          // value: widget.state,
          value: widget.list[widget.index],
          onChanged: (value) {
            setState(() {
              // widget.state = value;
              widget.list[widget.index] = !widget.list[widget.index];
            });
          },
        ),
        title: Text(
          widget.text,
          style: kBody2TextStyle,
        ),
      ),
    );
  }
}

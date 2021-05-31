import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class RuleDateItem extends StatelessWidget {

  final String text;
  final String time;
  final Size size;

  RuleDateItem({this.text, this.size, this.time});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      radius: Radius.circular(20),
      dashPattern: [8, 2],
      borderType: BorderType.RRect,
      child: Container(
        height: 80,
        width: size.width * 0.4,
        // decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.lock_clock,
              color: Colors.grey[300],
            ),
            Text(text),
            Text(time),
          ],
        ),
      ),
    );
  }
}

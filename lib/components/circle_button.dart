import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCircleButton extends StatelessWidget {
  final Function onPressed;
  final IconData iconData;
  final Size size;

  MyCircleButton({this.onPressed, this.iconData, this.size});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: Colors.blueGrey[800],
            ),
          ),
          child: Icon(
            iconData,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}

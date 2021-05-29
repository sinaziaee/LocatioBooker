import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCircleButton extends StatelessWidget {
  final Function onPressed;
  final IconData iconData;
  final Size size;
  bool isActivated;

  MyCircleButton({this.onPressed, this.iconData, this.size, this.isActivated});

  @override
  Widget build(BuildContext context) {
    if (this.isActivated == null) {
      this.isActivated = true;
    }
    if(this.isActivated){
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
                color: this.isActivated
                    ? Colors.blueGrey[800]
                    : Colors.blueGrey[200],
              ),
            ),
            child: Icon(
              iconData,
              color: this.isActivated ? Colors.blueGrey : Colors.blueGrey[200],
            ),
          ),
        ),
      );
    }
    else{
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: this.isActivated
                ? Colors.blueGrey[800]
                : Colors.blueGrey[200],
          ),
        ),
        child: Icon(
          iconData,
          color: this.isActivated ? Colors.blueGrey : Colors.blueGrey[200],
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';

class BackButtonItem extends StatefulWidget {
  const BackButtonItem({Key key}) : super(key: key);

  @override
  _BackButtonItemState createState() => _BackButtonItemState();
}

class _BackButtonItemState extends State<BackButtonItem> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 15,
      top: 15,
      child: SafeArea(
        child: Material(
          color: Colors.grey[700],
          shape: CircleBorder(),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

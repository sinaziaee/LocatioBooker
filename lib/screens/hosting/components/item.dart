import 'package:flutter/material.dart';

class Item extends StatelessWidget {

  final bool isSelected;

  Item({this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
    );
  }
}

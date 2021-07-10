import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';

class PayItem extends StatelessWidget {
  final int cost;
  final Function onPressed;

  PayItem({
    this.cost,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey,
      shape: CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$cost \$',
              style: kBody1TextStyle.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

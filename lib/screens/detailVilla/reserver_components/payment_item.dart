import 'package:flutter/material.dart';

import '../../../constants.dart';

class PaymentItem extends StatelessWidget {
  final IconData iconData;
  final String method;
  final Function onPressed;

  PaymentItem({
    this.iconData,
    this.method,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                method,
                style: kBody2TextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../constants.dart';

class PayButton extends StatelessWidget {
  final int cost;
  final Function onPayPressed;

  PayButton({
    this.cost,
    this.onPayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        child: Material(
          borderRadius: BorderRadius.circular(25),
          color: Colors.blueGrey[600],
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: onPayPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                // horizontal: 20,
                vertical: 15,
              ),
              child: Center(
                child: Text(
                  'Pay ${cost ?? ''} \$',
                  style: kBody2TextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

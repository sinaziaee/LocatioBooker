import 'package:flutter/material.dart';

import '../../../constants.dart';

class ButtonSelectDate extends StatelessWidget {
  final bool isReady;
  final Function onPressed;

  ButtonSelectDate({this.isReady, this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (isReady) {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(25),
          color: Colors.blueGrey[800],
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: onPressed,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.blueGrey[800],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      'Select Date',
                      style: kBody1TextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey[300],
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.blueGrey[800],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      'Select Date',
                      style: kBody1TextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

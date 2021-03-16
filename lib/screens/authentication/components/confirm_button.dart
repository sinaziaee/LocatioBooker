import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../login_screen.dart';

class MyConfirmButton extends StatelessWidget {

  final String text;
  final Function onPressed;

  MyConfirmButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: LoginScreen.size.width,
      height: LoginScreen.size.height * 0.06,
      margin: EdgeInsets.symmetric(
        horizontal: LoginScreen.size.width * 0.05,
      ),
      child: RaisedButton(
        color: Colors.red,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Continue',
          style: kBodyTextStyle.copyWith(
            color: Colors.white,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

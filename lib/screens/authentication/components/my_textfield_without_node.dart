import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../login_screen.dart';

class MyTestFieldWithoutNode extends StatelessWidget {
  final Color color;
  final bool isLast;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;

  MyTestFieldWithoutNode({this.hint, this.isPassword, this.color, this.controller, this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: LoginScreen.size.height * 0.06,
      margin: EdgeInsets.symmetric(
        // horizontal: LoginScreen.size.width * 0.01,
        vertical: LoginScreen.size.height * 0.005
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            bottom: LoginScreen.size.height * 0.03,
            left: LoginScreen.size.width * 0.03,
            right: LoginScreen.size.width * 0.03,
          ),
          hintText: hint,
          focusedBorder: kOutLineInputBorder.copyWith(
            borderSide: BorderSide(
              color: color ?? Colors.black,
              width: 1.5,
              style: BorderStyle.solid,
            ),
          ),
          border: kOutLineInputBorder.copyWith(
            borderSide: BorderSide(
              color: color ?? Colors.grey,
              width: 0.5,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}

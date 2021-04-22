import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../login_screen.dart';

class MyTestFieldWithoutNode extends StatelessWidget {
  final Color color;
  final bool isLast;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final Function(String search) onChanged;
  final Size size;

  MyTestFieldWithoutNode({
    this.hint,
    this.isPassword,
    this.color,
    this.controller,
    this.isLast,
    this.onChanged,
    @required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.06,
      margin: EdgeInsets.symmetric(
          // horizontal: LoginScreen.size.width * 0.01,
          vertical: size.height * 0.005),
      child: TextFormField(
        onChanged: onChanged,
        cursorColor: color ?? Colors.black,
        style: TextStyle(color: color ?? Colors.black),
        controller: controller,
        decoration: InputDecoration(
          // hintStyle: TextStyle(color: color ?? Colors.black),
          contentPadding: EdgeInsets.only(
            bottom: size.height * 0.03,
            left: size.width * 0.03,
            right: size.width * 0.03,
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

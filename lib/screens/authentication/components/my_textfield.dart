import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants.dart';
import '../login_screen.dart';

class MyTextField extends StatelessWidget {
  final Color color;
  final FocusNode node;
  final bool isLast;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final Size size;
  final bool isEyeShowed;
  final Function onEyePressed;

  MyTextField(
      {this.hint,
      this.isPassword,
      this.color,
      this.node,
      this.controller,
      this.isLast,
      this.onEyePressed,
      this.isEyeShowed,
      @required this.size});

  @override
  Widget build(BuildContext context) {
    if (isPassword == true && isEyeShowed != null) {
      return Container(
        height: size.height * 0.06,
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.005),
        child: TextFormField(
          cursorColor: Colors.black,
          controller: controller,
          obscureText: (isEyeShowed == true)
              ? false
              : true,
          onEditingComplete: () => (isLast == null || isLast == false)
              ? node.nextFocus()
              : node.unfocus(),
          decoration: InputDecoration(
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
            suffixIcon: IconButton(
                icon: Icon(
                  (isEyeShowed == true)
                      ? FontAwesomeIcons.solidEye
                      : FontAwesomeIcons.solidEyeSlash,
                  color: Colors.black,
                ),
                onPressed: onEyePressed),
          ),
        ),
      );
    } else {
      return Container(
        height: size.height * 0.06,
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.005),
        child: TextFormField(
          cursorColor: Colors.black,
          controller: controller,
          obscureText: isPassword,
          onEditingComplete: () => (isLast == null || isLast == false)
              ? node.nextFocus()
              : node.unfocus(),
          decoration: InputDecoration(
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
}

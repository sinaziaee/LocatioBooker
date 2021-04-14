import 'package:flutter/material.dart';

import '../../../constants.dart';

class MyTextField extends StatelessWidget {
  final Color color;
  final FocusNode node;
  final bool isLast;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final Size size;
  final TextInputType inputType;

  MyTextField(
      {this.hint,
      this.isPassword,
      this.color,
      this.node,
      this.controller,
      this.isLast,
      this.inputType,
      @required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.06,
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.01, vertical: size.height * 0.005),
      child: TextFormField(
        keyboardType: inputType ?? TextInputType.text,
        cursorColor: Colors.black,
        controller: controller,
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
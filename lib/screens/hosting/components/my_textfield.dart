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
  final int lines;
  final double height;

  MyTextField(
      {this.hint,
      this.lines,
      this.isPassword,
      this.color,
      this.node,
      this.controller,
      this.isLast,
      this.height,
      this.inputType,
      @required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 45,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.005),
      // margin: EdgeInsets.symmetric(
      //     horizontal: size.width * 0.01, vertical: size.height * 0.005),
      child: TextFormField(
        maxLines: 10,
        minLines: lines ?? 1,
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

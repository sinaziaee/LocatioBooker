import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loctio_booker/constants.dart';

class PayTextField extends StatelessWidget {
  final TextEditingController controller;

  PayTextField({
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        cursorColor: Colors.black,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          fillColor: Colors.grey[300],
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.only(
            bottom: 25,
            left: 20,
            right: 20,
          ),
        ),
        style: kBody2TextStyle.copyWith(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:loctio_booker/constants.dart';

class DetailDescription extends StatelessWidget {

  final String description;

  DetailDescription({this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,

      ),
      child: Text(
        description,
        style: kBody2TextStyle.copyWith(
          color: Colors.blueGrey[800],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SelectImageItem extends StatelessWidget {

  final String text;
  final IconData iconData;

  SelectImageItem({this.text, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '$text‌',
            textDirection: TextDirection.rtl,
            style: kBodyTextStyle.copyWith(color: Colors.grey[700]),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            iconData,
            color: Colors.grey[700],
          ),
        ],
      ),
    );
  }
}

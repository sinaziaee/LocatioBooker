import 'package:flutter/material.dart';

import '../../../constants.dart';

class DetailRowItem extends StatelessWidget {

  final IconData iconData;
  final String type, value;

  DetailRowItem({this.iconData, this.type, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Row(
        children: [
          Icon(iconData, color: Colors.blueGrey[700],),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: kBody1TextStyle.copyWith(
                  color: Colors.blueGrey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }
}

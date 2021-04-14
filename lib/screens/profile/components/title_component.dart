import 'package:flutter/material.dart';

import '../../../constants.dart';

class TitleComponent extends StatelessWidget {

  final String title;

  TitleComponent(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 25.0, right: 25.0, top: 25.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Column(
            mainAxisAlignment:
            MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                title,
                style: kBodyTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

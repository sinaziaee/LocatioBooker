import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: 20.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              /*Navigator.popAndPushNamed(
                                                context, Settings.id);*/
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: new Text(
              'my Profile',
              style: kHeaderTextStyle,
            ),
          )
        ],
      ),
    );
  }
}

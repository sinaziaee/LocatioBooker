import 'package:flutter/material.dart';
import 'package:loctio_booker/screens/authentication/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0, top: 10),
            child: new Text(
              'my Profile',
              style: kHeaderTextStyle,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            color: Colors.black,
            onPressed: () {
              logOut(context);
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.id,
      (route) => false,
    );
  }
}

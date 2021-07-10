import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/help/help_screen.dart';
import 'package:loctio_booker/screens/home/search_profile_screen.dart';
import 'package:loctio_booker/screens/profile/list_of_your_screen.dart';
import 'package:loctio_booker/screens/profile/personal_information_screen.dart';
import 'package:loctio_booker/screens/profile/terms_aggrements_screen.dart';
import '../../hosting/00_hosing_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SettingsPage extends StatefulWidget {
  static String id = 'setting_page';
  User user;
  Size size;

  SettingsPage();

  SettingsPage.user(User user, Size size) {
    this.user = user;
    this.size = size;
  }

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FocusNode node;
  Color color = Colors.black;
  String url = '$mainUrl/device/fcms/';
  String firstName, lastName;

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    print('$mainUrl${widget.user.image}');
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: widget.size.height * 0.01,
            width: widget.size.width * 0.01,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: (widget.user.image != null)
                    ? NetworkImage('$mainUrl${widget.user.image}')
                    : AssetImage(
                        'assets/images/as.jpg',
                      ),
                backgroundColor: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.user.firstName + ' ' + widget.user.lastName,
                    style: kHeaderTextStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PersonalInformation.id);
                    },
                    child: Text(
                      'View Profile',
                      style: kBody1TextStyle.copyWith(
                        color: Colors.blueGrey,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, PersonalInformation.id);
            },
            title: Text(
              'Account Settings',
              style: kBodyTextStyle,
            ),
            leading: Icon(Icons.person),
            trailing: Icon(Icons.chevron_right),
            key: Key('key_account_settings'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                SearchProfileScreen.id,
                arguments: {
                  'user': widget.user,
                },
              );
            },
            title: Text(
              'Users profiles',
              style: kBodyTextStyle,
            ),
            leading: Icon(Icons.accessibility),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text(
              'Hosting',
              style: kBodyTextStyle,
            ),
            trailing: Icon(Icons.chevron_right),
            leading: Icon(Icons.home),
            onTap: () {
              // Navigator.pushNamed(
              //   context,
              //   HostingScreen.id,
              //   arguments: {
              //     'user': widget.user,
              //   },
              // );
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HostingScreen(widget.user)),
              );
            },
          ),
          // ListTile(
          //   title: Text(
          //     'Payment',
          //     style: kBodyTextStyle,
          //   ),
          //   leading: Icon(Icons.money),
          //   trailing: Icon(Icons.more_vert),
          // ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YourPlaces(widget.user),
                ),
              );
            },
            title: Text(
              'List of your places',
              style: kBodyTextStyle,
            ),
            trailing: Icon(Icons.chevron_right),
            leading: Icon(Icons.place),
          ),
          // ListTile(
          //   title: Text(
          //     'Security',
          //     style: kBodyTextStyle,
          //   ),
          //   trailing: Icon(Icons.chevron_right),
          //   leading: Icon(Icons.security),
          // ),
          // ListTile(
          //   title: Text(
          //     'Update your password',
          //     style: kBodyTextStyle,
          //   ),
          //   trailing: Icon(Icons.chevron_right),
          //   leading: Icon(Icons.history),
          // ),
          // ListTile(
          //   title: Text(
          //     'Manage Connected Apps',
          //     style: kBodyTextStyle,
          //   ),
          //   trailing: Icon(Icons.chevron_right),
          //   leading: Icon(Icons.app_blocking),
          // ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HelpScreen();
                  },
                ),
              );
            },
            title: Text(
              'Help',
              style: kBodyTextStyle,
            ),
            trailing: Icon(Icons.chevron_right),
            leading: Icon(Icons.help_center_sharp),
          ),
          // ListTile(
          //   title: Text(
          //     'Asked Questions',
          //     style: kBodyTextStyle,
          //   ),
          //   trailing: Icon(Icons.chevron_right),
          //   leading: Icon(Icons.question_answer),
          //   onTap: () {
          //     postNotification();
          //   },
          // ),
          ListTile(
            title: Text(
              'Terms & Aggrements',
              style: kBodyTextStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, termsAggrements.id);
            },
            trailing: Icon(Icons.chevron_right),
            leading: Icon(Icons.laptop_windows),
          ),
        ],
      ),
    );
  }

  void postNotification() {
    http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: convert.json.encode(
        {
          'token': widget.user.firebaseToken,
          'message': 'Sina is a new person, it is unfortunate.',
          'title': 'New Notification',
        },
      ),
    );
  }
}

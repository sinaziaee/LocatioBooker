import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/authentication/login_screen.dart';
import 'package:loctio_booker/screens/profile/personal_information_screen.dart';
import 'package:loctio_booker/screens/profile/terms_aggrements_screen.dart';

class Settings extends StatefulWidget {
  static String id = 'setting_page';
  User user;
  Size size;

  Settings();

  Settings.user(User user, Size size) {
    this.user = user;
    this.size = size;
  }

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  FocusNode node;
  Color color = Colors.black;

  String firstName, lastName;

  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController passwordController;
  TextEditingController rePasswordController;
  TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    print(widget.user);
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
              new Container(
                width: 50.0,
                height: 50.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/as.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),                SizedBox(
                width: 20,
              ),
              Column(children: [
                Text(
                  widget.user.firstName + ' ' + widget.user.lastName,
                  style: kHeaderTextStyle,
                ),
                TextButton(
                  onPressed: () {
                    // Navigator.popAndPushNamed(context, LoginScreen.id);
                  },
                  child: Text('View Profile'),
                )
              ]),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              'Account Settings',
              style: kBodyTextStyle,
            ),
            leading: Icon(Icons.person),
            trailing: SizedBox(),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                PersonalInformationScreen.id,
                arguments: {
                  'user': widget.user,
                },
              );
            },
            title: Text(
              'Personal information',
              style: kBodyTextStyle,
            ),
            leading: Icon(Icons.accessibility),
            trailing: SizedBox(),
          ),
          ListTile(
            title: Text(
              'Hosting',
              style: kBodyTextStyle,
            ),
            trailing: Icon(Icons.more_vert),
            leading: Icon(Icons.home),
          ),
          ListTile(
            title: Text(
              'Payment',
              style: kBodyTextStyle,
            ),
            leading: Icon(Icons.money),
            trailing: Icon(Icons.more_vert),
          ),
          ListTile(
            title: Text(
              'List your place',
              style: kBodyTextStyle,
            ),
            trailing: Icon(Icons.more_vert),
            leading: Icon(Icons.place),
          ),
          ListTile(
            title: Text(
              'Security',
              style: kBodyTextStyle,
            ),
            trailing: Icon(Icons.more_vert),
            leading: Icon(Icons.security),
          ),
          ListTile(
            title: Text(
              'Update your password',
              style: kBodyTextStyle,
            ),
            trailing: Icon(Icons.more_vert),
            leading: Icon(Icons.history),
          ),
          ListTile(
            title: Text(
              'Manage Connected Apps',
              style: kBodyTextStyle,
            ),
            trailing: Icon(Icons.more_vert),
            leading: Icon(Icons.app_blocking),
          ),
          ListTile(
            title: Text(
              'Help',
              style: kBodyTextStyle,
            ),
            trailing: Icon(Icons.more_vert),
            leading: Icon(Icons.help_center_sharp),
          ),
          ListTile(
            title: Text(
              'Asked Questions',
              style: kBodyTextStyle,
            ),
            trailing: Icon(Icons.more_vert),
            leading: Icon(Icons.question_answer),
          ),
          ListTile(
            title: Text(
              'Terms & Aggrements',
              style: kBodyTextStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, termsAggrements.id);
            },
            trailing: Icon(Icons.more_vert),
            leading: Icon(Icons.laptop_windows),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/screens/authentication/components/my_textfield.dart';
import 'package:loctio_booker/screens/authentication/login_screen.dart';


class Settings extends StatefulWidget {
  static String id = 'setting_page';



  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  FocusNode node;
  Color color = Colors.black;

  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController passwordController;
  TextEditingController rePasswordController;
  TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit personal information' ,
          style: kHeaderTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height : LoginScreen.size.height * 0.01,
              width: LoginScreen.size.width * 0.01,
            ),
            Row(
              children: [
                CircleAvatar(),
              ],
            ),

            ListTile(
             title: Text('Account Settings' ,
              style: kHeaderTextStyle,
             ),
             leading: Icon(Icons.person),
             trailing: Icon(Icons.more_vert),
           ) ,
            ListTile(
              title: Text('Personal information' ,
                style: kHeaderTextStyle,
              ),
              leading: Icon(Icons.accessibility),
              trailing: Icon(Icons.more_vert),
            ),
            ListTile(
              title: Text('Hosting' ,
                style: kHeaderTextStyle,
              ),
              trailing: Icon(Icons.more_vert),
              leading: Icon(Icons.home),
            ),
            ListTile(
              title: Text('Payment' ,
                style: kHeaderTextStyle,
              ),
              leading: Icon(Icons.money),
              trailing: Icon(Icons.more_vert),
            ) ,
            ListTile(
              title: Text('List your place' ,
                style: kHeaderTextStyle,
              ),
              trailing: Icon(Icons.more_vert),
              leading: Icon(Icons.place),
            ),
            ListTile(
              title: Text('Security' ,
                style: kHeaderTextStyle,
              ),
              trailing: Icon(Icons.more_vert),
              leading: Icon(Icons.security),
            ),
            ListTile(
              title: Text('Update your password' ,
                style: kHeaderTextStyle,
              ),
              trailing: Icon(Icons.more_vert),
              leading: Icon(Icons.history),
            ),
            ListTile(
              title: Text('Manage Connected Apps' ,
                style: kHeaderTextStyle,
              ),
              trailing: Icon(Icons.more_vert),
              leading: Icon(Icons.app_blocking),
            ),
            ListTile(
              title: Text('Help' ,
                style: kHeaderTextStyle,
              ),
              trailing: Icon(Icons.more_vert),
              leading: Icon(Icons.help_center_sharp),
            ),
            ListTile(
              title: Text('Asked Questions' ,
                style: kHeaderTextStyle,
              ),
              trailing: Icon(Icons.more_vert),
              leading: Icon(Icons.question_answer),
            ),
            ListTile(
              title: Text('Terms & Aggrements' ,
                style: kHeaderTextStyle,
              ),
              trailing: Icon(Icons.more_vert),
              leading: Icon(Icons.laptop_windows),
            ),

          ],
        ),
      ),
    );
  }
}

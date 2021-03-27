import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/screens/authentication/components/my_textfield.dart';
import 'package:loctio_booker/screens/authentication/login_screen.dart';

class settings extends StatefulWidget {
  static String id = 'setting_page';



  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  FocusNode node;
  Color color = Colors.black;

  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController passwordController;
  TextEditingController rePasswordController;
  TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit personal information' ,
          style: kHeaderTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: LoginScreen.size.height * 0.03,),
            MyTestField(
              node: node,
              hint: 'First Name',
              color: Colors.black,
              controller: firstNameController,
              isLast: false,
              isPassword: false,
            ),
          ],
        ),
      ),
    );
  }
}

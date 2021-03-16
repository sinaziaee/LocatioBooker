import 'package:flutter/material.dart';

import 'components/my_textfield.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  FocusNode node;

  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController passwordController;
  TextEditingController rePasswordController;
  TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: LoginScreen.size.height * 0.03,
            ),
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

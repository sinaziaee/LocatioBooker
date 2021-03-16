import 'package:flutter/material.dart';
import 'package:loctio_booker/screens/home/home_screen.dart';

import 'components/confirm_button.dart';
import 'components/my_textfield.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'sign_up_screen';

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
            SizedBox(
              height: LoginScreen.size.height * 0.03,
            ),
            MyTestField(
              node: node,
              hint: 'Last Name',
              color: Colors.black,
              controller: lastNameController,
              isLast: false,
              isPassword: false,
            ),
            SizedBox(
              height: LoginScreen.size.height * 0.03,
            ),
            // MyTestField(
            //   node: node,
            //   hint: 'First Name',
            //   color: Colors.black,
            //   controller: firstNameController,
            //   isLast: false,
            //   isPassword: false,
            // ),
            // SizedBox(
            //   height: LoginScreen.size.height * 0.03,
            // ),
            MyTestField(
              node: node,
              hint: 'Password',
              color: Colors.black,
              controller: passwordController,
              isLast: false,
              isPassword: false,
            ),
            SizedBox(
              height: LoginScreen.size.height * 0.03,
            ),
            MyTestField(
              node: node,
              hint: 'Re-Password',
              color: Colors.black,
              controller: rePasswordController,
              isLast: false,
              isPassword: false,
            ),
            SizedBox(
              height: LoginScreen.size.height * 0.01,
            ),
            MyConfirmButton(
              onPressed: () {
                onContinuePressed();
              },
              text: 'Submit',
            ),
          ],
        ),
      ),
    );
  }

  void onContinuePressed() {
    Navigator.pushNamed(context, HomeScreen.id);
  }

}

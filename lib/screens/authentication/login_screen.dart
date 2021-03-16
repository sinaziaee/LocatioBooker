import 'package:flutter/material.dart';
import 'package:loctio_booker/screens/authentication/sign_up_screen.dart';
import 'package:loctio_booker/screens/home/home_screen.dart';

import '../../constants.dart';
import 'components/confirm_button.dart';
import 'components/my_login_card.dart';
import 'components/my_textfield.dart';
import 'components/my_textfield_without_node.dart';

class LoginScreen extends StatefulWidget {
  static Size size;
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode node;
  Color color;
  TextEditingController usernameController, passwordController;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    color = Colors.black;
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    LoginScreen.size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: LoginScreen.size.height * 0.1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: LoginScreen.size.width * 0.06,
              ),
              child: Text(
                'Log in or Sign up to Airbnb',
                style: kHeaderTextStyle.copyWith(
                  color: color,
                ),
              ),
            ),
            SizedBox(
              height: LoginScreen.size.height * 0.03,
            ),
            MyTestField(
              node: node,
              hint: 'Email',
              color: Colors.black,
              controller: usernameController,
              isLast: false,
              isPassword: false,
            ),
            // MyTestField(
            //   node: node,
            //   color: Colors.black,
            //   hint: 'Password',
            //   controller: passwordController,
            //   isLast: false,
            //   isPassword: true,
            // ),
            SizedBox(
              height: LoginScreen.size.height * 0.012,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: LoginScreen.size.width * 0.07,
              ),
              child: Text(
                'Enter your email or username and then your password, If you don\'t have any account it will automatically register your email',
                style: kBodyTextStyle.copyWith(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(
              height: LoginScreen.size.height * 0.016,
            ),
            MyConfirmButton(
              text: 'Continue',
              onPressed: () {
                onContinuePressed();
              },
            ),
            SizedBox(
              height: LoginScreen.size.height * 0.015,
            ),
            Center(
              child: Text(
                'or',
                style: kBodyTextStyle.copyWith(
                  color: color,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(
              height: LoginScreen.size.height * 0.015,
            ),
            LoginCard(
              color: Colors.white,
              borderColor: Colors.black,
              text: 'Continue with Google',
              imageAsset: 'assets/images/logo_google.png',
              onTapped: () {
                _showDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void onContinuePressed() {
    Navigator.pushNamed(context, SignUpScreen.id);
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Enter your password for confirmation',
            textAlign: TextAlign.center,
            style: kHeaderTextStyle.copyWith(
              color: color,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTestFieldWithoutNode(
                color: Colors.black,
                hint: 'Re-Password',
                controller: passwordController,
                isLast: false,
                isPassword: true,
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
        );
      },
    );
  }
}

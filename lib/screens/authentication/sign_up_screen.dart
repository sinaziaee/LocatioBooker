import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loctio_booker/screens/home/home_screen.dart';

import '../../constants.dart';
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
  Color color = Colors.black;

  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController passwordController;
  TextEditingController rePasswordController;
  TextEditingController phoneController;

  String email;
  Map args;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    args = ModalRoute.of(context).settings.arguments;
    email = args['email'];
    print('e: $email');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: LoginScreen.size.height * 0.03,
              ),
              Text(
                email,
                style: kBodyTextStyle.copyWith(
                  color: Colors.grey,
                ),
              ),
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
                isLast: true,
                isPassword: false,
              ),
              SizedBox(
                height: LoginScreen.size.height * 0.03,
              ),
              Container(
                height: LoginScreen.size.height * 0.06,
                margin: EdgeInsets.symmetric(
                    horizontal: LoginScreen.size.width * 0.05,
                    vertical: LoginScreen.size.height * 0.005),
                child: IntlPhoneField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      bottom: LoginScreen.size.height * 0.03,
                      left: LoginScreen.size.width * 0.03,
                      right: LoginScreen.size.width * 0.03,
                    ),
                    hintText: 'Phone Number',
                    focusedBorder: kOutLineInputBorder.copyWith(
                      borderSide: BorderSide(
                        color: color ?? Colors.black,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                    ),
                    border: kOutLineInputBorder.copyWith(
                      borderSide: BorderSide(
                        color: color ?? Colors.grey,
                        width: 0.5,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
              ),
              SizedBox(
                height: LoginScreen.size.height * 0.06,
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
      ),
    );
  }

  void onContinuePressed() {
    Navigator.pushNamed(context, HomeScreen.id);
  }
}

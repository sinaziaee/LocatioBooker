import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/authentication/verification_screen.dart';
import 'package:loctio_booker/screens/home/home_screen.dart';
import 'package:loctio_booker/static_methods.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../constants.dart';
import '../../components/custom_dialog.dart';
import 'components/confirm_button.dart';
import 'components/my_textfield.dart';
import 'components/phone_textfield.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'sign_up_screen';
  static int theCode;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FocusNode node;
  Color color = Colors.black;
  String url = '$mainUrl/api/register/';
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController passwordController;
  TextEditingController rePasswordController;
  TextEditingController phoneController;

  String email, country, token;
  Map args;
  User user;

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
                (email.length != 0) ? email : 'Email here',
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
              PhoneTextField(
                phoneController: phoneController,
                color: color,
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

  bool isValidated() {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text;
    String rePassword = rePasswordController.text;
    if (firstName.length < 3) {
      _showDialog('Bad First Name Format');
      return false;
    } else if (lastName.length < 3) {
      _showDialog('Bad Last Name Format');
      return false;
    } else if (phone.length < 3) {
      _showDialog('Bad Phone Format');
      return false;
    } else if (password.length < 3) {
      _showDialog('Bad Password Format');
      return false;
    } else if (rePassword.length < 3) {
      _showDialog('Bad RePassword Format');
      return false;
    }
    if (password == rePassword) {
      _showDialog('Password and Re-Password do not match');
      return false;
    }
    user = User(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        password: password,
        country: country,
        token: token);
    return true;
  }

  void onContinuePressed() {
    // if(isValidated()){
    //   Navigator.pushNamed(context, HomeScreen.id);
    // }
    // else{
    //   // pass
    // }
    Navigator.pushNamed(context, VerificationScreen.id);
  }

  uploadInfo() async {
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: convert.jsonEncode(
          user.toJson(),
        ),
      );
      if (response.statusCode < 400) {
        StaticMethods.showSuccessDialog(
            context, 'Your are logged in successfully');
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        print(jsonResponse);
        // saveInfo();
      } else {
        StaticMethods.showErrorDialog(
            context, 'An Error happened while logging in');
        print(response.body);
      }
    } catch (e) {
      print('sth went wrong with: $e');
    }
  }

  saveInfo() async {
    await StaticMethods.saveToPreferences(
      firstName: user.firstName,
      lastName: user.lastName,
      token: user.token,
      email: user.email,
      password: user.password,
      phone: user.phone,
      country: user.country,
    );
  }

  _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          color: color,
          text: 'OK !!!',
          onPressed: () {
            Navigator.pop(context);
          },
          message: message,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
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
  String sendEmailUrl = '$mainUrl/api/account/send-email';
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
      StaticMethods.showErrorDialog(context, 'Bad First Name Format');
      return false;
    } else if (lastName.length < 3) {
      StaticMethods.showErrorDialog(context, 'Bad Last Name Format');
      return false;
    } else if (phone.length < 3) {
      StaticMethods.showErrorDialog(context, 'Bad Phone Format');
      return false;
    } else if (password.length < 3) {
      StaticMethods.showErrorDialog(context, 'Bad Password Format');
      return false;
    } else if (rePassword.length < 3) {
      StaticMethods.showErrorDialog(context, 'Bad RePassword Format');
      return false;
    }
    if (password != rePassword) {
      StaticMethods.showErrorDialog(
          context, 'Password and Re-Password do not match');
      return false;
    }
    user = User(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      password: password,
      country: country,
    );
    return true;
  }

  void onContinuePressed() {
    if (isValidated()) {
      sendVerificationEmail();
    } else {
      // pass
    }
  }

  sendVerificationEmail() async {
    try {
      http.Response response = await StaticMethods.upload(
        sendEmailUrl,
        user.toJson(),
      );
      print('statusCode: ${response.statusCode}');
      if (response.statusCode < 400) {
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        print(jsonResponse);
        SignUpScreen.theCode = jsonResponse['vc_code'];
        Navigator.pushNamed(context, VerificationScreen.id);
      } else {
        StaticMethods.showErrorDialog(
            context, 'An Error happened while signing up');
        print(response.body);
      }
    } catch (e) {
      StaticMethods.printError(e.toString());
    }
  }

  saveInfo() async {
    await StaticMethods.saveToPreferences(user);
    Navigator.pushNamedAndRemoveUntil(
      context,
      HomeScreen.id,
      (route) => false,
      arguments: {
        'user': user,
      },
    );
    // Navigator.pushNamed(
    //   context,
    //   VerificationScreen.id,
    //   arguments: {
    //     'user': user,
    //   },
    // );
  }
}

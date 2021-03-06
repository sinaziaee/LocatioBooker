import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/authentication/verification_screen.dart';
import 'package:loctio_booker/static_methods.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert' as convert;
import '../../constants.dart';
import 'components/confirm_button.dart';
import 'components/my_textfield.dart';
import 'components/phone_textfield.dart';

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
  Size size;
  String email, country, token, countryCode;
  Map args;
  User user;
  bool isEyeShowed1 = false, isEyeShowed2 = false;

  bool showSpinner = false;

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
    size = MediaQuery.of(context).size;
    print('e: $email');
    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: kMyProgressIndicator,
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Text(
                  (email.length != 0) ? email : 'Email here',
                  style: kBodyTextStyle.copyWith(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                MyTextField(
                  size: size,
                  node: node,
                  hint: 'First Name',
                  color: Colors.black,
                  controller: firstNameController,
                  isLast: false,
                  isPassword: false,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                MyTextField(
                  size: size,
                  node: node,
                  hint: 'Last Name',
                  color: Colors.black,
                  controller: lastNameController,
                  isLast: false,
                  isPassword: false,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                MyTextField(
                  node: node,
                  hint: 'Password',
                  color: Colors.black,
                  controller: passwordController,
                  isLast: false,
                  isPassword: true,
                  size: size,
                  isEyeShowed: isEyeShowed1,
                  onEyePressed: (){
                    setState(() {
                      isEyeShowed1 = !isEyeShowed1;
                    });
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                MyTextField(
                  size: size,
                  node: node,
                  hint: 'Re-Password',
                  color: Colors.black,
                  controller: rePasswordController,
                  isLast: true,
                  isPassword: true,
                  isEyeShowed: isEyeShowed2,
                  onEyePressed: (){
                    setState(() {
                      isEyeShowed2 = !isEyeShowed2;
                    });
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                PhoneTextField(
                  size: size,
                  phoneController: phoneController,
                  color: color,
                  onPhoneChanged: onPhoneChanged,
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                MyConfirmButton(
                  size: size,
                  onPressed: () {
                    onContinuePressed();
                  },
                  text: 'Submit',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPhoneChanged(PhoneNumber value){
    // print(value.number);
    countryCode = value.countryCode;
    print(value.countryCode);
    return;
  }

  bool isValidated() {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text;
    String rePassword = rePasswordController.text;
    print(phone);
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
      phone: '$countryCode$phone',
      email: email,
      password: password,
      nationalCode: countryCode,
    );
    print(user.phone);
    print('---------------------------------');
    print(user.userId);
    return true;
  }

  void onContinuePressed() {
    if (isValidated()) {
      showSpinner = true;
      setState(() {});
      sendVerificationEmail();
    } else {
      // pass
    }
  }

  sendVerificationEmail() async {
    print('---------------------------------');
    print(user.userId);
    try {
      http.Response response = await StaticMethods.upload(
        sendEmailUrl,
        user.toJson(),
      );
      showSpinner = false;
      setState(() {});
      print('statusCode: ${response.statusCode}');
      if (response.statusCode < 400) {
        var jsonResponse =
        convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        print(response.body);
        SignUpScreen.theCode = jsonResponse['vc_code'];
        Navigator.pushNamed(
          context,
          VerificationScreen.id,
          arguments: {
            'user': user,
          },
        );
      } else {
        StaticMethods.showErrorDialog(
            context, 'An Error happened while signing up');
        print(response.body);
      }
    } catch (e) {
      showSpinner = false;
      setState(() {});
      StaticMethods.printError(e.toString());
    }
  }
}

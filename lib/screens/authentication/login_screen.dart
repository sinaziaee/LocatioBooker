import 'package:flutter/material.dart';
import 'package:loctio_booker/components/custom_dialog.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/authentication/sign_up_screen.dart';
import 'package:loctio_booker/screens/home/home_screen.dart';
import '../../constants.dart';
import '../../static_methods.dart';
import 'components/confirm_button.dart';
import 'components/my_login_card.dart';
import 'components/my_textfield.dart';
import 'components/my_textfield_without_node.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class LoginScreen extends StatefulWidget {
  static Size size;
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode node;
  Color color;
  TextEditingController emailController, passwordController;

  User user;
  String url = '$mainUrl/api/login/';

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    color = Colors.black;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
              controller: emailController,
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
                onContinuePressed();
              },
            ),
          ],
        ),
      ),
    );
  }

  void onContinuePressed() {
    String email = emailController.text.toString();
    // if(isValidated(email)){
    //   print(email);
    //   Navigator.pushNamed(context, SignUpScreen.id, arguments: {'email': email});
    // }
    // else{
    //   _showDialog('Bad email format');
    // }

    Navigator.pushNamed(context, SignUpScreen.id, arguments: {'email': email});
  }

  _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          color: color,
          text: 'OK !!!',
          onPressed: (){
            Navigator.pop(context);
          },
          message: message,
        );
      },
    );
  }

  bool isValidated(String email){
    if(email.length < 3 || !email.contains("@")){
      print('wrong');
      return false;
    }
    return true;
  }

  uploadInfo() async {
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: convert.jsonEncode(
          user.toJson(),
        ),
      );
      if(response.statusCode < 400){
        StaticMethods.showSuccessDialog(context, 'Your information was uploaded successfully');
        var jsonResponse = convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        print(jsonResponse);
        // saveInfo();
      }
      else {
        StaticMethods.showErrorDialog(context, 'An Error happened while uploading information');
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

}

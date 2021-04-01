import 'package:flutter/material.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/authentication/sign_up_screen.dart';
import 'package:loctio_booker/screens/home/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool showSpinner = false;
  User user;
  String url = '$mainUrl/api/account/login';
  String checkExistenceUrl = '$mainUrl/api/account/check-existence';

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      user = User(
        firstName: prefs.getString('firstName'),
        lastName: prefs.getString('lastName'),
        token: prefs.getString('firstName'),
        email: prefs.getString('firstName'),
        password: prefs.getString('firstName'),
        country: prefs.getString('country'),
        phone: prefs.getString('phone'),
      );
      Navigator.popAndPushNamed(context, HomeScreen.id, arguments: {
        'user': user,
      });
    }
  }

  @override
  void initState() {
    getToken();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    color = Colors.black;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    LoginScreen.size = MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: kMyProgressIndicator,
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
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
                  'Log in or Sign up to Locatio',
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
                isLast: true,
                isPassword: false,
              ),
              SizedBox(
                height: LoginScreen.size.height * 0.012,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: LoginScreen.size.width * 0.07,
                ),
                child: Text(
                  'Enter your email and then your password, If you don\'t have any account it will automatically register your email',
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
      ),
    );
  }

  void onContinuePressed() {
    String email = emailController.text.toString();
    if (isValidated(email)) {
      print(email);
      showSpinner = true;
      setState(() {});
      checkEmailExistence(email);
    } else {
      StaticMethods.showErrorDialog(context, 'Bad email format');
    }
  }

  bool isValidated(String email) {
    if (email.length < 3 || !email.contains("@")) {
      print('wrong');
      return false;
    }
    return true;
  }

  checkEmailExistence(String email) async {
    try {
      http.Response response = await StaticMethods.upload(
        checkExistenceUrl,
        {
          'email': email,
        },
      );
      showSpinner = false;
      setState(() {});
      print(response.statusCode);
      if (response.statusCode < 400) {
        print(response.body);
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        print(jsonResponse);
        showPasswordDialog();
      } else if (response.statusCode == 404) {
        print(response.body);
        Navigator.pushNamed(context, SignUpScreen.id,
            arguments: {'email': email});
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      showSpinner = false;
      setState(() {});
      StaticMethods.printError(e);
    }
  }

  bool checkPasswordValidation() {
    String password = passwordController.text;
    String email = emailController.text;
    if (password.length < 6) {
      StaticMethods.showErrorDialog(context, 'Bad Password format');
      return false;
    }
    if (email.length < 6) {
      StaticMethods.showErrorDialog(context, 'Bad Email format');
      return false;
    }
    user = User(
      email: email,
      password: password,
    );
    return true;
  }

  uploadInfo() async {
    print(user.email);

    try {
      http.Response response = await StaticMethods.upload(
        url,
        {
          'username': user.email,
          'password': user.password,
        },
      );
      print(response.statusCode);
      if (response.statusCode < 400) {
        Navigator.pop(context);
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        user = User.fromJson(jsonResponse);
        saveInfo();
      } else if (response.statusCode == 400) {
        StaticMethods.showErrorDialog(context, 'Wrong Password');
        print(response.body);
      } else {
        StaticMethods.showErrorDialog(
            context, 'An Error happened while uploading information');
        print(response.body);
      }
    } catch (e) {
      StaticMethods.printError(e.toString());
    }
  }

  saveInfo() async {
    user.token = 'Token ${user.token}';
    await StaticMethods.saveToPreferences(
      user,
    );
    Navigator.popAndPushNamed(context, HomeScreen.id, arguments: {
      'user': user,
    });
  }

  showPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Enter Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTestFieldWithoutNode(
                hint: 'Password',
                isPassword: true,
                isLast: true,
                controller: passwordController,
                color: Colors.black,
              ),
              SizedBox(
                height: LoginScreen.size.height * 0.05,
              ),
              MyConfirmButton(
                color: Colors.red,
                text: 'Submit',
                onPressed: () {
                  if (checkPasswordValidation()) {
                    uploadInfo();
                  } else {
                    // pass
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

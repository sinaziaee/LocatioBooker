import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/authentication/components/confirm_button.dart';
import 'package:loctio_booker/screens/authentication/components/my_textfield.dart';
import 'package:loctio_booker/screens/authentication/login_screen.dart';
import 'package:loctio_booker/screens/authentication/sign_up_screen.dart';
import 'package:loctio_booker/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:loctio_booker/static_methods.dart';

class VerificationScreen extends StatefulWidget {
  static String id = 'verification_screen';

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  String url = '$mainUrl/api/account/register';
  String sendEmailUrl = '$mainUrl/api/account/send-email';
  String code = '';
  int verifTime = 180;
  AnimationController controller;
  Animation<double> animation;
  int progress = 0;
  FocusNode node;
  Map args;
  User user;
  TextEditingController verificationController;
  Color color = Colors.black;

  @override
  void initState() {
    reset();
    verificationController = TextEditingController();
    controller = AnimationController(
        duration: const Duration(seconds: 180), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
          progress = (animation.value * 120).round();
        });
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  void reset() {
    Future.delayed(
      Duration(
        seconds: verifTime,
      ),
      () {
        SignUpScreen.theCode = null;
        sendVerificationCode();
        print('signUpCode was resat to: ${SignUpScreen.theCode}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    args = ModalRoute.of(context).settings.arguments as Map;
    user = args['user'];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LoginScreen.size.width * 0.04,
            ),
            child: Text(
              'Please Enter a verification code',
              style: kBodyTextStyle,
            ),
          ),
          SizedBox(
            height: LoginScreen.size.height * 0.02,
          ),
          MyTestField(
            color: color,
            controller: verificationController,
            isPassword: false,
            isLast: true,
            node: node,
            hint: 'Verification Code',
          ),
          SizedBox(
            height: LoginScreen.size.height * 0.01,
          ),
          Center(
            child: (progress != verifTime)
                ? Text((verifTime - progress).toString() + ' Remaining time: ')
                : Text('Code was Expired'),
          ),
          SizedBox(
            height: LoginScreen.size.height * 0.01,
          ),
          Theme(
            data: ThemeData(
              accentColor: Colors.purple,
            ),
            child: Container(
              child: LinearProgressIndicator(
                value: animation.value,
                backgroundColor: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: LoginScreen.size.height * 0.03,
          ),
          Row(
            children: [
              Expanded(
                child: MyConfirmButton(
                  onPressed: () {
                    onResetPressed();
                  },
                  text: 'Reset',
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: MyConfirmButton(
                  onPressed: () {
                    onCancelPressed();
                  },
                  text: 'Cancel',
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onCancelPressed() {
    Navigator.pop(context);
  }

  void onResetPressed() {
    reset();
    // Navigator.pushNamed(context, HomeScreen.id);
  }

  uploadInfo() async {
    try {
      http.Response response = await StaticMethods.upload(
        url,
        user.toJson(),
      );
      print('statusCode: ${response.statusCode}');
      if (response.statusCode < 400) {
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        print(jsonResponse);
        user = User.fromJson(jsonResponse);
        saveInfo();
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

  sendVerificationCode() async {
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
      } else {
        StaticMethods.showErrorDialog(
            context, 'An Error happened while signing up');
        print(response.body);
      }
    } catch (e) {
      StaticMethods.printError(e.toString());
    }
  }
}

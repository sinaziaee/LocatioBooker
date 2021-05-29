import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/authentication/components/confirm_button.dart';
import 'package:loctio_booker/screens/authentication/components/my_textfield.dart';
import 'package:loctio_booker/screens/authentication/sign_up_screen.dart';
import 'package:loctio_booker/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:loctio_booker/static_methods.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class VerificationScreen extends StatefulWidget {
  static String id = 'verification_screen';

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  String url = '$mainUrl/api/account/register';
  String sendEmailUrl = '$mainUrl/api/account/send-email';
  String typedCode = '';
  int verifTime = 120;
  AnimationController controller;
  Animation<double> animation;
  int progress = 0;
  FocusNode node;
  Map args;
  User user;
  TextEditingController verificationController;
  Color color = Colors.black;
  Size size;
  bool showSpinner = false;

  @override
  void initState() {
    // reset();
    verificationController = TextEditingController();
    controller = AnimationController(
        duration: const Duration(seconds: 120), vsync: this);
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
        showSpinner = true;
        setState(() {});
        SignUpScreen.theCode = null;
        // sendVerificationCode();
        print('signUpCode was resat to: ${SignUpScreen.theCode}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    node = FocusScope.of(context);
    args = ModalRoute.of(context).settings.arguments as Map;
    user = args['user'];
    return Scaffold(
        body: ModalProgressHUD(
      progressIndicator: kMyProgressIndicator,
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                ),
                child: Text(
                  'Please Enter a verification code',
                  style: kBodyTextStyle,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              MyTextField(
                size: size,
                color: color,
                controller: verificationController,
                isPassword: false,
                isLast: true,
                node: node,
                hint: 'Verification Code',
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              MyConfirmButton(
                size: size,
                color: (progress != verifTime)
                    ? Colors.red
                    : Colors.redAccent[100],
                onPressed: () {
                  if(progress == verifTime){
                    return;
                  }
                  typedCode = verificationController.text;
                  if (typedCode.length == 0) {
                    StaticMethods.showErrorDialog(
                        context, 'Please type the code first');
                    return;
                  }
                  if (typedCode != SignUpScreen.theCode.toString()) {
                    StaticMethods.showErrorDialog(
                        context, 'Wrong verification code');
                    return;
                  }
                  showSpinner = true;
                  setState(() {});
                  uploadInfo();
                },
                text: 'Continue',
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Center(
                child: (progress != verifTime)
                    ? Text(
                        'Remaining time: ${verifTime - progress}s',
                        style: kBodyTextStyle.copyWith(fontSize: 16),
                      )
                    : Text(
                        'Code was Expired',
                        style: kBodyTextStyle.copyWith(
                            fontSize: 16, color: Colors.grey),
                      ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              (progress != verifTime)
                  ? Theme(
                      data: ThemeData(
                        accentColor: Colors.red,
                      ),
                      child: Container(
                        child: Center(
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: CircularProgressIndicator(
                              strokeWidth: 10,
                              value: animation.value,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.timer_off_outlined,
                        color: Colors.redAccent[100],
                        size: 200,
                      ),
                    ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                children: [
                  Expanded(
                    child: MyConfirmButton(
                      size: size,
                      onPressed: () {
                        onResetPressed();
                      },
                      text: 'Reset',
                      color: (progress != verifTime) ? Colors.grey : Colors.red,
                    ),
                  ),
                  Expanded(
                    child: MyConfirmButton(
                      size: size,
                      onPressed: () {
                        onCancelPressed();
                      },
                      text: 'Cancel',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void onCancelPressed() {
    Navigator.pop(context);
  }

  void onResetPressed() {
    if(progress != verifTime){
      // pass
    }
    else{
      SignUpScreen.theCode = null;
      sendVerificationEmail();
      // showSpinner = true;
      // setState(() {});
      // SignUpScreen.theCode = null;
      // sendVerificationCode();
      // print('signUpCode was resat to: ${SignUpScreen.theCode}');
    }
  }

  sendVerificationEmail() async {
    setState(() {
      showSpinner = true;
    });
    print(user.toJson().toString());
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
        Navigator.popAndPushNamed(
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

  uploadInfo() async {
    try {
      http.Response response = await StaticMethods.upload(
        url,
        user.toJson(),
        vcCode: typedCode,
      );
      showSpinner = false;
      setState(() {});
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
      showSpinner = false;
      setState(() {});
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
  }
}

import 'package:flutter/material.dart';
import 'package:loctio_booker/screens/authentication/sign_up_screen.dart';
import 'package:loctio_booker/screens/authentication/verification_screen.dart';
import 'package:loctio_booker/screens/profile/profile.dart';
import 'package:loctio_booker/screens/profile/settings.dart';
import 'package:loctio_booker/screens/profile/personalInformation.dart';
import 'package:loctio_booker/screens/profile/termsAggrements.dart';

import 'screens/authentication/login_screen.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        VerificationScreen.id: (context) => VerificationScreen(),
        Settings.id : (context) => Settings(),
        profile.id : (context) => profile(),
        personalInformation.id : (context) => personalInformation(),
        termsAggrements.id : (context) => termsAggrements()
      },
    );
  }
}

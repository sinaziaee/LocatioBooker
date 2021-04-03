import 'package:flutter/material.dart';
import 'package:loctio_booker/screens/authentication/sign_up_screen.dart';
import 'package:loctio_booker/screens/authentication/verification_screen.dart';
import 'package:loctio_booker/screens/home/search_profile_screen.dart';

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
        SearchProfileScreen.id: (context) => SearchProfileScreen(),
      },
    );
  }
}

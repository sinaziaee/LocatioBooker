import 'package:flutter/material.dart';
import 'package:loctio_booker/screens/addVilla/facility.dart';
import 'package:loctio_booker/screens/authentication/sign_up_screen.dart';
import 'package:loctio_booker/screens/authentication/verification_screen.dart';
import 'package:loctio_booker/screens/profile/profile.dart';
import 'package:loctio_booker/screens/profile/settings.dart';
import 'package:loctio_booker/screens/profile/personal_information_screen.dart';
import 'package:loctio_booker/screens/profile/terms_aggrements_screen.dart';
import 'screens/authentication/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/search_profile_screen.dart';

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
        ProfileScreen.id : (context) => ProfileScreen(),
        PersonalInformationScreen.id : (context) => PersonalInformationScreen(),
        termsAggrements.id : (context) => termsAggrements(),
        SearchProfileScreen.id: (context) => SearchProfileScreen(),
        facility_villa.id:(context) => facility_villa(),
      },
    );
  }
}

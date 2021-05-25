import 'package:flutter/material.dart';
import 'package:loctio_booker/screens/authentication/sign_up_screen.dart';
import 'package:loctio_booker/screens/authentication/verification_screen.dart';
import 'package:loctio_booker/screens/home/result_screen.dart';
import 'package:loctio_booker/screens/profile/profile_screen.dart';
import 'package:loctio_booker/screens/profile/settings_page.dart';
import 'package:loctio_booker/screens/profile/personal_information_screen.dart';
import 'package:loctio_booker/screens/profile/terms_aggrements_screen.dart';
import 'screens/authentication/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/search_profile_screen.dart';
import 'screens/home/search_place_screen.dart';
import 'screens/detailVilla/detailVillaScreen.dart';
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
        SettingsPage.id : (context) => SettingsPage(),
        ProfileScreen.id : (context) => ProfileScreen(),
        PersonalInformation.id : (context) => PersonalInformation(),
        termsAggrements.id : (context) => termsAggrements(),
        SearchProfileScreen.id: (context) => SearchProfileScreen(),
        detailVillaScreen.id: (context) => detailVillaScreen(),
        ResultScreen.id: (context) => ResultScreen(),
        // HostingScreen.id: (context) => HostingScreen(),
        // SearchSpaceScreen.id: (context) => SearchSpaceScreen(null),
      },
    );
  }
}

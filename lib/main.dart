import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/screens/authentication/sign_up_screen.dart';
import 'package:loctio_booker/screens/authentication/verification_screen.dart';
import 'package:loctio_booker/screens/chat/chat_screen.dart';
import 'package:loctio_booker/screens/home/result_screen.dart';
import 'package:loctio_booker/screens/profile/profile_screen.dart';
import 'package:loctio_booker/screens/profile/settings_page.dart';
import 'package:loctio_booker/screens/profile/personal_information_screen.dart';
import 'package:loctio_booker/screens/profile/terms_aggrements_screen.dart';
import 'screens/authentication/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/search_profile_screen.dart';
import 'screens/home/search_city_screen.dart';
import 'screens/detailVilla/detail_villa_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ChatScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        VerificationScreen.id: (context) => VerificationScreen(),
        SettingsPage.id: (context) => SettingsPage(),
        ProfileScreen.id: (context) => ProfileScreen(),
        PersonalInformation.id: (context) => PersonalInformation(),
        termsAggrements.id: (context) => termsAggrements(),
        SearchProfileScreen.id: (context) => SearchProfileScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}

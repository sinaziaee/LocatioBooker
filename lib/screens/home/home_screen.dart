import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/authentication/login_screen.dart';
import 'package:loctio_booker/screens/profile/settings.dart';
import 'package:loctio_booker/screens/home/search_profile_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  Color color;

  Map args;
  User user;
  String token;
  Size size;

  Widget bodyContainer(int index) {
    if (index == 0) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  logOut();
                },
              ),
            ],
          ),
        ],
      );
    }
    else if(index == 4){
      return Settings.user(user, size);
    }
    else if(index == 1){
      return AppBar(
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){
            Navigator.pushNamed(context, SearchProfileScreen.id, arguments: {
              'user': user,
            },);
          },),
        ],
      );
    }
    else {
      return Container();
    }
  }

  @override
  void initState() {
    color = Colors.black;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    args = ModalRoute.of(context).settings.arguments;
    user = args['user'];
    print('user.token in HomeScreen: ${user.token}');
    token = user.token;
    return Scaffold(
      body: SafeArea(
        child: bodyContainer(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            title: Text(
              'Search',
              style: TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.heart,
              color: Colors.black,
              size: 18,
            ),
            title: Text(
              'Saved',
              style: TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.info,
              color: Colors.black,
              size: 16,
            ),
            title: Text(
              'Tips',
              style: TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.messenger_outline,
              color: Colors.black,
            ),
            title: Text(
              'Inbox',
              style: TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_pin,
              color: Colors.black,
            ),
            // label: 'Profile',
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        onTap: (val) {
          selectedIndex = val;
          setState(() {});
        },
        currentIndex: selectedIndex,
      ),
    );
  }

  logOut() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.popAndPushNamed(context, LoginScreen.id);
  }

}

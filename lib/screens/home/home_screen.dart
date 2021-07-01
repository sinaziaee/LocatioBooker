import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/home/pages/chat_rooms_page.dart';
import 'package:loctio_booker/screens/home/pages/favorite_villas_page.dart';
import 'package:loctio_booker/screens/profile/settings_page.dart';
import 'pages/home_page.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  final Key key = Key('home_screen_key');

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
      return HomePage(size, user);
    } // 1
    else if (index == 1) {
      return FavoriteVillasPage(user);
    } // 2
    else if (index == 2) {
      return ChatRoomsPage(
        user: user,
      );
    } // 3
    else if (index == 3) {
      return SettingsPage.user(user, size);
    } // >= 4
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
    token = user.token;
    print('******************* Home Screen *********************');
    print(user.firebaseToken);
    print('*****************************************************');
    return Scaffold(
      body: SafeArea(
        child: bodyContainer(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: Key('bottom_navigation'),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
              key: Key('bnbi_home'),
            ),
            title: Text(
              'Villa',
              key: Key('bnbi_villa'),
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
              key: Key('bnbi_profile'),
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
}

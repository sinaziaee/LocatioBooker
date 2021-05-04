import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/hosting/01_resort_type_screen.dart';
import 'package:loctio_booker/screens/hosting/components/apartment_not_found_component.dart';
import 'package:loctio_booker/static_methods.dart';


class HostingScreen2 extends StatefulWidget {
  static String id = 'hosting_screen';

  @override
  _HostingScreenState2 createState() => _HostingScreenState2();
}

class _HostingScreenState2 extends State<HostingScreen2> {
  Size size;

  Map args;

  //User user;
  User myUser = User(
    firstName: 'Ahmad' ,
    bio: "Finally life becomes sweet",
    country: 'Russia' ,
    email: 'AhmadNorollahi@gmail.com',
    filename: 'A' ,
    nationalCode: '9393939',
    gender: 'Male',
    image: 'Alli',
    lastName: 'Razavi',
    password: '191919191',
    phone: '09197373737',
    token: 'Token 02929292992'
  );

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    args = ModalRoute.of(context).settings.arguments;
    //user = args['user'];
    // user.printUser();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: StaticMethods.myAppBar('Hosting Screen', context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Your Accommodations List',
              style: kHeaderTextStyle.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            ApartmentNotFoundComponent(
              size: size,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResortTypeScreen(myUser)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

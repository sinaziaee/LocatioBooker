import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/static_methods.dart';
import 'category_screen.dart';
import 'resort_type_screen.dart';
import 'components/apartment_not_found_component.dart';

class HostingScreen extends StatefulWidget {
  static String id = 'hosting_screen';

  @override
  _HostingScreenState createState() => _HostingScreenState();
}

class _HostingScreenState extends State<HostingScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
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
            MaterialPageRoute(builder: (context) => ResortTypeScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

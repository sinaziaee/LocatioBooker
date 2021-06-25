import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/static_methods.dart';
import '01_resort_type_screen.dart';
import 'components/apartment_not_found_component.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HostingScreen extends StatefulWidget {
  static String id = 'hosting_screen';

  final User user;
  final Key key = Key('hosting_screen_key');

  HostingScreen(this.user);

  @override
  _HostingScreenState createState() => _HostingScreenState();
}

class _HostingScreenState extends State<HostingScreen> {
  Size size;
  String getAllUsersVillasUrl = '$mainUrl/api/villa/user/';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    getAllUsersVilla();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: StaticMethods.myAppBar(
        'Hosting Screen',
        context,
        widget.user,
        isVisible: false,
      ),
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
            MaterialPageRoute(
                builder: (context) => ResortTypeScreen(widget.user)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  getAllUsersVilla() async{
    http.Response response = await http.get(
      Uri.parse(getAllUsersVillasUrl),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
      },
    );
    var jsonResponse = convert.json.decode(response.body);
    print(jsonResponse);
  }
}

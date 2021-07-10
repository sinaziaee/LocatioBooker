import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/components2/back_icon.dart';
import 'package:loctio_booker/screens/detailVilla/detail_villa_screen.dart';
import 'package:loctio_booker/screens/hosting/components/host_place_item.dart';
import 'package:loctio_booker/screens/hosting/components/nothing_found.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../constants.dart';

class YourPlaces extends StatefulWidget {
  final User user;

  YourPlaces(this.user);

  @override
  _YourPlacesState createState() => _YourPlacesState();
}

class _YourPlacesState extends State<YourPlaces> {
  Size size;
  String hostingUrl = '$mainUrl/api/villa/user/me/?hosted';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: FutureBuilder(
              future: getInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  http.Response response = snapshot.data;
                  if (response.statusCode < 400) {
                    var jsonResponse = convert.json.decode(response.body);
                    print(jsonResponse);
                    List mapList = [];
                    int count = 0;
                    for (Map each in jsonResponse['data']) {
                      mapList.add(each);
                      count++;
                    }
                    if (count == 0) {
                      return Center(
                        child: NothingFound(
                          image: 'assets/images/resort/no_house.jpg',
                          size: size,
                          text1: 'You haven\'t hosted any villa',
                          text2: '',
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: count,
                      itemBuilder: (context, index) {
                        Villa villa = Villa.fromJson(mapList[index]);
                        return HostPlaceItem(
                          size: size,
                          villa: villa,
                          last: count == index + 1,
                          onPressed: () {
                            onHostItemPressed(villa);
                          },
                        );
                      },
                    );
                  } //
                  else {
                    return Center(
                      child: Text(
                        'An error occurred',
                        style: kHeaderTextStyle.copyWith(),
                      ),
                    );
                  }
                  // return Container();
                } else {
                  return Center(
                    child: kMyProgressIndicator,
                  );
                }
              },
            ),
          ),
          BackButtonItem(),
        ],
      ),
    );
  }

  getInfo() async {
    try {
      http.Response response = await http.get(
        Uri.parse(hostingUrl),
        headers: {
          HttpHeaders.authorizationHeader: widget.user.token,
        },
      );
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void onHostItemPressed(Villa villa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailVillaScreen(villaId: villa.villaId, user: widget.user);
        },
      ),
    );
  }
}

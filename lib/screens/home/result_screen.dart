import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/place.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/static_methods.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart' as convert;
import 'package:latlong/latlong.dart' as latLng;

import 'components/custom_place_item.dart';
import 'components/custom_result_map.dart';

class ResultScreen extends StatefulWidget {
  static String id = 'result_screen';
  final User user;
  final Key key = Key('result_screen');
  final Map map;
  ResultScreen({@required this.user, @required this.map});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String imageUrl = '';
  Size size;
  String resultText = 'Kish. 4 to 17 October';
  String city = 'N/A';
  int accNo = 154;
  String allPlacesUrl = '';
  List<Map> mapList = [];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    print('==========================================');
    // print(widget.map);

    getAllPlaces(widget.map);

    return Scaffold(
      appBar: StaticMethods.resultAppBar(context, resultText, size),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomResultMap(
            size: size,
            mapList: mapList,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 10,
              bottom: 5,
            ),
            child: Text(
              'Reserve Villa, suite, Accommodation in $city',
              style: kBody1TextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              '$accNo places',
              style: kBody2TextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return CustomPlaceItem(
                  size: size,
                  place: Place(
                    city: 'Hormozgan',
                    country: 'Iran',
                    id: 1,
                    images: [imageUrl],
                    latitude: 0.0,
                    longitude: 0.0,
                    maxCapacity: 3,
                    price: 900,
                    name: 'two single bedrooms',
                    rate: 4.3,
                    state: 'Hormozgan',
                    numberOfBedrooms: 3,
                  ),
                );
              },
            ),
          ),
          // FutureBuilder(
          //   future: getPlaces(),
          //   builder: (context, snapshot) {
          //     return ListView.builder(
          //       itemBuilder: (context, index) {
          //         return CustomPlaceItem(
          //           size: size,
          //           place: Place(),
          //         );
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Future<http.Response> getPlaces() async {
    return await http.get(
      Uri.parse(allPlacesUrl),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
      },
    );
  }

  getAllPlaces(Map map){
    // print(map['data']);
    for (Map each in map['data']){
      mapList.add(each);
      print(each);
    }

  }

}















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
  final latLng.LatLng location;
  final String city;
  final String startDate, endDate;

  ResultScreen({
    @required this.user,
    @required this.map,
    this.location,
    this.city,
    this.startDate,
    this.endDate,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String imageUrl = '';
  Size size;
  String resultText;
  int accNo = 154;
  String allPlacesUrl = '';
  List<Map> mapList = [];

  @override
  Widget build(BuildContext context) {
    resultText =
        '${widget.city}. ${widget.startDate.substring(8, 10)} to ${widget.endDate.substring(8, 10)} ${StaticMethods.getMonthString(
      int.parse(
        widget.startDate.substring(5, 7),
      ),
    )}';
    size = MediaQuery.of(context).size;
    print('==========================================');
    // print(widget.map);

    getAllPlaces(widget.map);

    return Scaffold(
      appBar: StaticMethods.resultAppBar(context, resultText, size),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // SliverAppBar(
            //   title: CustomResultMap(
            //       size: size, mapList: mapList, location: widget.location),
            // ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: size.height * 0.22,
              flexibleSpace: Expanded(
                child: CustomResultMap(
                    size: size, mapList: mapList, location: widget.location),
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomResultMap(
            //     size: size, mapList: mapList, location: widget.location),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: 10,
                bottom: 5,
              ),
              child: Text(
                'Reserve Villa, suite, Accommodation in ${widget.city}',
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
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: mapList.length,
                itemBuilder: (context, index) {
                  return CustomPlaceItem(
                    size: size,
                    user: widget.user,
                    place: Place(
                      city: mapList[index]['city'],
                      country: mapList[index]['country'],
                      id: mapList[index]['villa_id'],
                      images: [mapList[index]['default_image_url']],
                      latitude: mapList[index]['latitude'],
                      longitude: mapList[index]['longitude'],
                      maxCapacity: mapList[index]['villa_id'],
                      price: mapList[index]['price_per_night'],
                      name: mapList[index]['name'],
                      rate: mapList[index]['rate'],
                      state: mapList[index]['state'],
                      numberOfBedrooms: mapList[index]['price_per_night'],
                    ),
                  );
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

  getAllPlaces(Map map) {
    print('---------------------');
    for (Map each in map['data']) {
      mapList.add(each);
      print(each);
    }
  }
}
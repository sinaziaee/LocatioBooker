import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:loctio_booker/models/search_model.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:latlong/latlong.dart' as latLng;
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/static_methods.dart';

import '../../constants.dart';

class ResultMapScreen extends StatefulWidget {
  final User user;
  final Key key = Key('result_map_screen');
  final List mapListLocations;
  final List<SearchModel> mapListVilla;
  final latLng.LatLng location;
  final int count;

  ResultMapScreen({
    this.user,
    this.location,
    this.mapListLocations,
    this.mapListVilla,
    this.count,
  });

  @override
  _ResultMapScreenState createState() => _ResultMapScreenState();
}

class _ResultMapScreenState extends State<ResultMapScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    print(widget.mapListVilla);
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.myAppBar('Map Selection', context, widget.user,
          isVisible: false),
      body: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: size.height - 60,
            ),
            child: Expanded(
              child: FlutterMap(
                options: MapOptions(
                  center: widget.location,
                  zoom: 12.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  MarkerLayerOptions(
                    // markers: [
                    //   // Marker(
                    //   //   width: 40.0,
                    //   //   height: 40.0,
                    //   //   point: latLng.LatLng(36.314845, 59.555513),
                    //   //   builder: (ctx) => Container(
                    //   //     child: Icon(
                    //   //       Icons.account_circle,
                    //   //       color: Colors.red.shade900,
                    //   //     ),
                    //   //   ),
                    //   // ),
                    // ],
                    markers: getAllLocations(),
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   right: 10,
          //   bottom: 10,
          //   child: Container(
          //     height: 150,
          //     width: 400,
          //     child: Expanded(
          //       child: ListView.builder(
          //         scrollDirection: Axis.horizontal,
          //         itemCount: widget.count,
          //         itemBuilder: (context, index) {
          //           return SizedBox(
          //             height: 140,
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            right: 10,
            left: 10,
            bottom: 10,
            child: Container(
              height: 150,
              width: size.width,
              color: Colors.grey,
              child: ListView.builder(
                itemCount: widget.count,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    child: Row(
                      children: [
                        ClipRRect(
                          child: FadeInImage(
                            placeholder:
                                AssetImage('assets/images/home_def.jpg'),
                            image: (widget.mapListVilla[index].url != null && widget.mapListVilla[index].url.length != 0)
                                ? NetworkImage(widget.mapListVilla[index].url)
                                : AssetImage('assets/images/home_def.jpg'),
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Marker> getAllLocations() {
    List locList = [];
    List<Marker> markerList = [];
    for (Map each in widget.mapListLocations) {
      latLng.LatLng loc = latLng.LatLng(each['latitude'], each['longitude']);
      locList.add(loc);
      markerList.add(Marker(
        width: 40.0,
        height: 40.0,
        point: loc,
        builder: (ctx) => Container(
          // child: Icon(
          //   Icons.location_pin,
          //   color: Colors.red.shade700,
          //   size: 30,
          // ),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                '${each['price_per_night'].toString()}\$',
                style: kBody1TextStyle.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ));
    }
    // print(markerList);
    return markerList;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as latLng;
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/search_model.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/home/result_map_screen.dart';

class CustomResultMap extends StatelessWidget {
  final Size size;
  final List mapListLocations;
  final latLng.LatLng location;
  final int count;
  final User user;

  CustomResultMap({
    this.size,
    this.mapListLocations,
    this.user,
    this.location,
    this.count,
  });


  @override
  Widget build(BuildContext context) {
    // print('******************');
    // print(mapListLocations);
    return Stack(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: size.height * 0.22,
          ),
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: FlutterMap(
              options: MapOptions(
                center: location,
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
        Positioned(
          right: 10,
          bottom: 10,
          child: Material(
            color: Colors.grey[700],
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ResultMapScreen(
                        location: location,
                        user: user,
                        count: count,
                        mapListLocations: mapListLocations,
                        mapListVilla: getVillas(),
                      );
                    },
                  ),
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.zoom_out_map_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List getVillas(){
    List<SearchModel> list = [];
    for (Map each in mapListLocations){
      SearchModel searchModel = SearchModel(
        country: each['country'],
        state: each['state'],
        city: each['city'],
        url: each['url'],
        name: each['name'],
        pricePerNight: each['price_per_night'],
        rate: each['rate'],
        villaId: each['villaId'],
      );
      list.add(searchModel);
      // print(each);
    }
    return list;
  }

  List<Marker> getAllLocations() {
    List locList = [];
    List<Marker> markerList = [];
    for (Map each in mapListLocations) {
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

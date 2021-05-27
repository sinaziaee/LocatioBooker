import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as latLng;
import 'package:loctio_booker/constants.dart';

class CustomResultMap extends StatelessWidget {
  final Size size;
  final mapList;
  final latLng.LatLng location;

  CustomResultMap({
    this.size,
    this.mapList,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    print('******************');
    print(mapList);
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
              onTap: () {},
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

  List<Marker> getAllLocations() {
    List locList = [];
    List<Marker> markerList = [];
    for (Map each in mapList) {
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                each['price_per_night'].toString(),
                style: kBody1TextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ));
    }
    print(markerList);
    return markerList;
  }
}

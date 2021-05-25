import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as latLng;

class CustomResultMap extends StatelessWidget {

  final Size size;

  CustomResultMap({this.size});

  @override
  Widget build(BuildContext context) {
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
                center: latLng.LatLng(36.314845, 59.555513),
                zoom: 15.0,
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 40.0,
                      height: 40.0,
                      point: latLng.LatLng(36.314845, 59.555513),
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.red.shade900,
                        ),
                      ),
                    ),
                  ],
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

              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.zoom_out_map_outlined, color: Colors.white,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

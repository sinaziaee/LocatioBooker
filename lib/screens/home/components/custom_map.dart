import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;

class CustomMap extends StatelessWidget {
  final Size size;

  CustomMap(this.size);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height*0.32,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: FlutterMap(
          options: MapOptions(
            // center: LatLng(51.5, -0.09),
            center: latLng.LatLng(36.314845, 59.555513),
            zoom: 15.0,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 40.0,
                  height: 40.0,
                  point: latLng.LatLng(36.314845, 59.555513),
                  builder: (ctx) => Container(
                    // child: FlutterLogo(
                    //
                    // ),
                    // child: Image.asset('assets/images/marker.png', height: 20, width: 20,),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.red.shade900,
                    ),
                    // child: Container(
                    //   height: 40,
                    //   width: 20,
                    //   decoration: BoxDecoration(
                    //     color: Colors.red,
                    //     borderRadius: BorderRadius.only(
                    //       bottomLeft: Radius.circular(10),
                    //       bottomRight: Radius.circular(10),
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;

class CustomMap extends StatefulWidget {
  final Size size;

  CustomMap(this.size);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.size.height * 0.32,
      ),
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: widget.size.width * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: FlutterMap(
          options: MapOptions(
            center: latLng.LatLng(51.5, -0.09),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']
            ),
            // MarkerLayerOptions(
            //   markers: [
            //     Marker(
            //       width: 80.0,
            //       height: 80.0,
            //       point: latLng.LatLng(51.5, -0.09),
            //       builder: (ctx) =>
            //           Container(
            //             child: FlutterLogo(),
            //           ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

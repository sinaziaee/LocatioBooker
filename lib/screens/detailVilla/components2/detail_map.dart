import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;

import '../../../constants.dart';

class DetailsMap extends StatelessWidget {
  final latLng.LatLng location;

  DetailsMap({this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Accommodation geographic location',
            style: kBody1TextStyle.copyWith(
              fontSize: 18,
              color: Colors.blueGrey[700],
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          child: FlutterMap(
            options: MapOptions(
              center: location,
              zoom: 16.0,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 70.0,
                    height: 70.0,
                    point: location,
                    builder: (ctx) => InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        // todo: animate to specific child index
                        // animatedMapMove(loc, 14);
                        // scrollController.animateTo(150 * index * 1.0,
                        //     duration: Duration(microseconds: 1000),
                        //     curve: Curves.ease);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueGrey.withOpacity(0.4),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.house,
                            color: Colors.blueGrey[700],
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top:20, bottom: 5),
          child: Text(
            'Exact location will be sent after reservation',
            style: kBody1TextStyle.copyWith(
              color: Colors.blueGrey[800],
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

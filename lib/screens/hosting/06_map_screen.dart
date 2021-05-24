import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:loctio_booker/models/facilitation.dart';
import 'package:loctio_booker/models/place_address.dart';
import 'package:loctio_booker/models/resort_description.dart';
import 'package:loctio_booker/models/resort_identification.dart';
import 'package:loctio_booker/models/user.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:loctio_booker/screens/hosting/components/bottom_container.dart';
import 'package:loctio_booker/static_methods.dart';
import 'package:opencage_geocoder/opencage_geocoder.dart';

class MapScreen extends StatefulWidget {
  final String villa;
  final ResortDescription resortDescription;
  final ResortIdentification resortIdentification;
  final Facilitation facilitation;
  final PlaceAddress placeAddress;
  final Key key = Key('map_screen_key');
  final User user;
  final latLng.LatLng location;

  MapScreen({
    this.villa,
    @required this.user,
    this.resortDescription,
    this.resortIdentification,
    this.facilitation,
    this.placeAddress,
    this.location,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Size size;
  bool isActivated;
  var geocoder = new Geocoder("7efb20c96c1a4cd594654de3842cd476");
  // Completer<GoogleMapController> _controller = Completer();
  List<Marker> markList = [];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // getLocation();
    // controller.move(widget.location, 10);
    return Scaffold(
      appBar: StaticMethods.myAppBar('Map Location', context, widget.user),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.8,
              ),
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlutterMap(
                  options: MapOptions(
                    center: widget.location,
                    zoom: 14.0,
                    onTap: (location){
                      print(location);
                      markList.clear();
                      markList.add(Marker(
                        width: 100.0,
                        height: 100.0,
                        point: location,
                        builder: (ctx) => Container(
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.red.shade700,
                            size: 50,
                          ),
                        ),
                      ));
                      setState(() {

                      });
                    }
                  ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    MarkerLayerOptions(
                      markers: markList,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            BottomContainer(
              key: widget.key,
              onPressed: () {

              },
              isActivated: isActivated,
              size: size,
              text: 'Submit & Continue',
            ),
          ],
        ),
      ),
    );
  }

  // Future<Coordinates> getLocation() async{
  //   print(widget.placeAddress.state);
  //   var response = await geocoder.geocode("tehran");
  //   Coordinates coordinates = response.results[0].geometry;
  //   print(coordinates);
  //   return coordinates;
  // }

}

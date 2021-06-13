import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/facilitation.dart';
import 'package:loctio_booker/models/place_address.dart';
import 'package:loctio_booker/models/resort_description.dart';
import 'package:loctio_booker/models/resort_identification.dart';
import 'package:loctio_booker/models/user.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:loctio_booker/screens/hosting/07_laws_screen.dart';
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
  latLng.LatLng placeLocation;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 13, top: size.height * 0.01, bottom: size.height * 0.02),
              child: Text(
                'Locate your villa',
                style: kBody1TextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.68,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlutterMap(
                  options: MapOptions(
                      center: widget.location,
                      zoom: 14.0,
                      onTap: (location) {
                        print(location);
                        placeLocation = latLng.LatLng(
                            location.latitude, location.longitude);
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
                        setState(() {});
                      }),
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
            BottomContainer(
              key: Key('map_bottom_key'),
              onPressed: () {
                if (markList.length == 0) {
                  StaticMethods.showErrorDialog(context,
                      'Please add a marker of your place location on the map');
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LawsScreen(
                      villa: widget.villa,
                      resortDescription: widget.resortDescription,
                      resortIdentification: widget.resortIdentification,
                      facilitation: widget.facilitation,
                      placeAddress: widget.placeAddress,
                      user: widget.user,
                      location: latLng.LatLng(placeLocation.latitude, placeLocation.longitude),
                    ),
                  ),
                );
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

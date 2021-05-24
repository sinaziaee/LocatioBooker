import 'package:flutter/material.dart';
import 'package:loctio_booker/models/facilitation.dart';
import 'package:loctio_booker/models/place_address.dart';
import 'package:loctio_booker/models/resort_description.dart';
import 'package:loctio_booker/models/resort_identification.dart';
import 'package:loctio_booker/models/user.dart';
import "package:latlong/latlong.dart" as latLng;

class LawsScreen extends StatefulWidget {
  final String villa;
  final ResortDescription resortDescription;
  final ResortIdentification resortIdentification;
  final Facilitation facilitation;
  final PlaceAddress placeAddress;
  final Key key = Key('laws_screen_key');
  final User user;
  final latLng.LatLng location;

  LawsScreen({
    this.villa,
    @required this.user,
    this.resortDescription,
    this.resortIdentification,
    this.facilitation,
    this.placeAddress,
    this.location,
  });

  @override
  _LawsScreenState createState() => _LawsScreenState();
}

class _LawsScreenState extends State<LawsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

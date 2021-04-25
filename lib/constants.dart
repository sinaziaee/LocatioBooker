import 'package:flutter/material.dart';

final kOutLineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
);

final kHeaderTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

final kBodyTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

final kMyProgressIndicator = Container(
  height: 70,
  width: 70,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey,
  ),
  child: Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    ),
  ),
);

final String mainUrl = 'https://softcheetahs.herokuapp.com';
// final String mainUrl = 'http://192.168.43.126:8000';

final kCustomAppBarDecoration = BoxDecoration(
  color: Colors.blueAccent,
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30)
  ),
);

class AccommodationType{
  static String villa = 'Villa';
  static String hotel = 'Hotel';
  static String suite = 'Suite';
  static String motel = 'Motel';
  static String apartment = 'Apartment';
  static String house = 'House';
  static String cottage = 'Cottage';
  static String residentialComplex = 'Residential Complex';
  static String hostel = 'Hostel';
  static String ecoTourism = 'EcoTourism';
  static String traditionalAccommodation = 'Traditional accommodation';
}

class ResortType{
  static String coastal = 'Coastal';
  static String urban = 'Urban';
  static String rural = 'Rural';
  static String desert = 'Desert';
  static String mountainous = 'Mountainous';
  static String forest = 'Forest';
  static String wild = 'Wild';
  static String suburban = 'Suburban';
}
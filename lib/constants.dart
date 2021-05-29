import 'package:flutter/material.dart';

final kOutLineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
);

final kHeaderTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

final kBody1TextStyle = TextStyle(
  fontSize: 15,
  color: Colors.black,
);

final kBody2TextStyle = TextStyle(
  fontSize: 15,
  color: Colors.grey[800],
);

final kBody3TextStyle = TextStyle(
  fontSize: 13,
  color: Colors.grey[700],
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

// final String mainUrl = 'https://softcheetahs.herokuapp.com';
final String mainUrl = 'http://192.168.43.126:8000';

final tempHouseImage = 'https://www.google.com/search'
    '?q=home+image&tbm=isch&ved=2ahUKEwj-momlkbHwAhUb'
    'qHIEHQTsBQgQ2-cCegQIABAA&oq=home+image&gs_lcp=Cg'
    'NpbWcQA1DXAVjeB2C0CWgAcAB4AIABAIgBAJIBAJgBAKABAa'
    'oBC2d3cy13aXotaW1nwAEB&sclient=img&ei=qNKRYP6mGZ'
    'vQytMPhNiXQA&rlz=1C1GCEA_enIR887IR887#imgrc=xMUT'
    'i5g8jurAmM';

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
  static String motel = 'Motel';
  static String desert = 'Desert';
  static String mountainous = 'Mountainous';
  // static String forest = 'Forest';
  static String wild = 'Wild';
  static String suburban = 'Suburban';
}
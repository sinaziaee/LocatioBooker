import 'package:bubble/bubble.dart';
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

final leftDecoration = BoxDecoration(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    bottomLeft: Radius.circular(20),
  ),
  border: Border.all(
    color: Colors.blueGrey[800],
    width: 1,
  ),
);

final rightDecoration = BoxDecoration(
  borderRadius: BorderRadius.only(
    bottomRight: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
  border: Border.all(
    color: Colors.blueGrey[800],
    width: 1,
  ),
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

final kRightColor = Colors.blueGrey[300];
final kLeftColor = Colors.white;

final styleSomebody = BubbleStyle(
  nip: BubbleNip.leftCenter,
  color: Colors.white,
  borderColor: Colors.blueGrey,
  borderWidth: 1,
  elevation: 4,
  margin: BubbleEdges.only(top: 8, right: 50),
  alignment: Alignment.topLeft,
);

final styleMe = BubbleStyle(
  nip: BubbleNip.rightCenter,
  color: Color.fromARGB(255, 225, 255, 199),
  borderColor: Colors.blueGrey,
  borderWidth: 1,
  elevation: 4,
  margin: BubbleEdges.only(top: 8, left: 50),
  alignment: Alignment.topRight,
);

// final String mainUrl = 'https://softcheetahs.herokuapp.com';
final String mainUrl = 'http://192.168.43.126:8000';

final tempHouseImage = 'http://licotab.ir/home/img/clients/sina-ziaee.jpeg';

final kCustomAppBarDecoration = BoxDecoration(
  color: Colors.blueGrey,
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
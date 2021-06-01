import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/models/resort_identification.dart';
import 'package:loctio_booker/models/user.dart';
import 'dart:convert' as convert;
import 'aboutVilla2.dart';

import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/components/aboutVilla.dart';
import 'package:loctio_booker/screens/detailVilla/components/imagesVilla.dart';

//String token = 'Token bab330f8321c61a9ba457fab4efc1b223c3f8731';

class detailVillaScreen3 extends StatefulWidget {
  static String id = 'detail_Villa_Screen';
  final url = 'https://softcheetahs.herokuapp.com/api/villa/user/?villa_id=$id';

  final String ownerName;
  final int price;
  final String images;
  final int capacity;




  detailVillaScreen3
      ({Key key, this.ownerName, this.price, this.images, this.capacity}) : super(key: key);




  @override
  _detailVillaScreenState3 createState() => _detailVillaScreenState3();
}

class _detailVillaScreenState3 extends State<detailVillaScreen3> {

  int id = 1;
  Map args ;

  @override
  Widget build(BuildContext context) {
    //user.token = 'Token 6626bc03c498cd5bc51e2b7bea1d71653a5c17ae';
    Villa myVilla = Villa(
      id: 2,
      name: "beautiful villa",
      type: "Suburban",
      description: "Luxury villa",
      price : 120,
      country: "Iran",
      state: "Kerman Province",
      city: "Kerman",
      address: "kerman, iran",
      postalCode: "1234556786",
      latitude: 2.156,
      longitude: 3.33,
      area: 1300,
      capacity: 3,
      maxCapacity: 4,
      numberOfBathrooms: 3,
      numberOfBedrooms: 3,
      numberOfSingleBeds: 3,
      numberOfDoubleBeds: 3,
      numberOfShowers: 3,

      images: [
        "/live-static/villas/images/photo-1582268611958-ebfd161ef9cf.jfif",
        "/live-static/villas/images/download.jfif",
        "/live-static/villas/images/photo-1513328250-0f6d9129e248.jfif",
        "/live-static/villas/images/photo-1531971589569-0d9370cbe1e5_NLdlucp.jfif"
      ],
      facilities: [
        "Refrigerator",
        "Cooking basics",
        "Furniture",
        "Microwave",
        "Hair dryer",
        "TV",
        "Oven",
        "Fireplace"
      ],

    );

    return Material(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Detail Villa"),
          ),
            body:  SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    //imagesVilla(myVilla),
                    aboutVilla2(myVilla),

              ],
          ),
        ),
      )
    );

  }

  }






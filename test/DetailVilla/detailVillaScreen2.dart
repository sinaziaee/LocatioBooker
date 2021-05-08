import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/models/user.dart';
import 'dart:convert' as convert;

import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/components/aboutVilla.dart';
import 'package:loctio_booker/screens/detailVilla/components/imagesVilla.dart';

//String token = 'Token bab330f8321c61a9ba457fab4efc1b223c3f8731';

class detailVillaScreen2 extends StatefulWidget {
  static String id = 'detail_Villa_Screen';
  final url = 'https://softcheetahs.herokuapp.com/api/villa/user/?villa_id=$id';

  final String ownerName;
  final int price;
  final String images;
  final int capacity;




  detailVillaScreen2
      ({Key key, this.ownerName, this.price, this.images, this.capacity}) : super(key: key);




  @override
  _detailVillaScreenState2 createState() => _detailVillaScreenState2();
}

class _detailVillaScreenState2 extends State<detailVillaScreen2> {

  //User user;

  int id = 1;
  Map args ;



  @override
  Widget build(BuildContext context) {
    //user.token = 'Token 6626bc03c498cd5bc51e2b7bea1d71653a5c17ae';


    return Material(
      child: FutureBuilder(
        future: http.get(Uri.parse("https://softcheetahs.herokuapp.com/api/villa/user/?villa_id=$id") , headers:{
          HttpHeaders.authorizationHeader : 'Token 6626bc03c498cd5bc51e2b7bea1d71653a5c17ae',
        }),
        builder: (context  ,snapshot){
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
            http.Response response = snapshot.data;
            //print(response.statusCode);
            print(response.body);

            Villa myVilla = Villa.fromJson(jsonDecode(response.body));

            return Scaffold(
              appBar: AppBar(
                title: Text("Detail Villa"),
              ),
              body:  SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    imagesVilla(myVilla),
                    aboutVilla(myVilla),

                  ],
                ),
              ),
            );
          }

          else if(snapshot.hasError){
            //print("url : $url");
            print("snapshot.error.toString()");
            // print("name :  ${snapshot.data.name}");
            print("error : ${snapshot.error.toString()}");
            return Padding(
                padding: EdgeInsets.all(140),
                child: Text("snapshot.error.toString()"));
          }

          return Center(child: CircularProgressIndicator());
        },

      ),
    );
  }




}

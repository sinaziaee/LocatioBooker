import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:loctio_booker/models/villa.dart';
import '../detailVilla/components/aboutVilla.dart';

import '../detailVilla/components/imagesVilla.dart';
String token = 'Token bab330f8321c61a9ba457fab4efc1b223c3f8731';

class detailVillaScreen extends StatefulWidget {
  static String id = 'detail_Villa_Screen';
  final url = 'https://softcheetahs.herokuapp.com/api/villa/user/?villa_id=$id';

  final String ownerName;
  final int price;
  final String images;
  final int capacity;

  detailVillaScreen
      ({Key key, this.ownerName, this.price, this.images, this.capacity}) : super(key: key);




  @override
  _detailVillaScreenState createState() => _detailVillaScreenState();
}

class _detailVillaScreenState extends State<detailVillaScreen> {
  final url = 'https://softcheetahs.herokuapp.com/api/villa/user/?villa_id=2';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
        future: http.get(Uri.parse(url) , headers:{
          HttpHeaders.authorizationHeader : token,
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
              body:  Column(
                children: [
                  SizedBox(height: 20,),
                  imagesVilla(myVilla),
                  aboutVilla(myVilla),

                ],
              ),
            );
          }

          else if(snapshot.hasError){
            print("url : $url");
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

  ListView _imagesListView(data){
    return ListView.builder(
      // ignore: missing_return
      itemBuilder:  (context , index){
        //return _tile(data[index].position , data[index].image);
      },
      itemCount: data.length,

    );
  }

  ListTile _tile() => ListTile(

  );

  ///*
  Future<Villa> _fetchImages(int id) async{
    print("here");

    final url = 'https://softcheetahs.herokuapp.com/api/villa/user/?villa_id=$id';
    http.Response response = await http.get(Uri.parse(url) , headers:{
      HttpHeaders.authorizationHeader : token,
    });

    print("body : ${response.body}");
    print("statusCode : ${response.statusCode}}");

    if(response.statusCode == 200){
      print(response.body.toString());
      return Villa.fromJson(jsonDecode(response.body));
    }

    else{
      //throw exception('Exception');
      print('Exception1');
      return null;
    }



  }//*/

}

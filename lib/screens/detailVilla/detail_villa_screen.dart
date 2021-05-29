import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/models/user.dart';
import 'dart:convert' as convert;

import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/components/myDivider.dart';
import 'package:loctio_booker/screens/detailVilla/components/reserveVilla.dart';
import '../../constants.dart';
import '../detailVilla/components/aboutVilla.dart';

import '../detailVilla/components/imagesVilla.dart';

class DetailVillaScreen extends StatefulWidget {
  final int villaId;
  final User user;
  DetailVillaScreen({@required this.villaId,@required this.user});

  @override
  _DetailVillaScreenState createState() => _DetailVillaScreenState();
}

class _DetailVillaScreenState extends State<DetailVillaScreen> {
  @override
  Widget build(BuildContext context) {

    return Material(
      child: FutureBuilder(
        future: http.get(
            Uri.parse(
                "$mainUrl/api/villa/user/?villa_id=${widget.villaId}"),
            headers: {
              HttpHeaders.authorizationHeader: widget.user.token,
            }),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            http.Response response = snapshot.data;
            print(response.statusCode);
            print(response.body);


            Villa myVilla = Villa.fromJson(jsonDecode(response.body));

            return Scaffold(
              appBar: AppBar(
                title: Text("Detail Villa"),
                leading: IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    imagesVilla(myVilla),
                    aboutVilla(myVilla),
                    myDivider(),
                    ReserveVilla(myVilla , widget.user)
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            //print("url : $url");
            print("snapshot.error.toString()");
            // print("name :  ${snapshot.data.name}");
            print("error : ${snapshot.error.toString()}");
            return Padding(
                padding: EdgeInsets.all(140),
                child: Text("snapshot.error.toString()"));
          }

          return Center(child: kMyProgressIndicator);
        },
      ),
    );
  }

  ListView _imagesListView(data) {
    return ListView.builder(
      // ignore: missing_return
      itemBuilder: (context, index) {
        //return _tile(data[index].position , data[index].image);
      },
      itemCount: data.length,
    );
  }

  ListTile _tile() => ListTile();

  ///*

}

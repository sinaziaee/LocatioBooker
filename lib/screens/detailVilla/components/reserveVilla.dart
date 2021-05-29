import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/components/circle_button.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/components/myDivider.dart';
import 'dart:convert' as convert;


DateTime entrySelectedDate = DateTime.now();
DateTime exitSelectedDate = DateTime.now();
int numPassengers = 1;

class reserveVilla extends StatefulWidget {

  Villa myVilla;
  User user;

  reserveVilla(this.myVilla , this.user);


  @override
  _reserveVillaState createState() => _reserveVillaState();
}

class _reserveVillaState extends State<reserveVilla> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text("Do you want to reserve this Villa ? Lets Start" ,
            style: kHeaderTextStyle,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "${entrySelectedDate.toLocal()}".split(' ')[0],
              style: kHeaderTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectEntryDate(context);
                });
              }, // Refer step 3
              child: Text(
                'Select Entry date',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              //color: Colors.greenAccent,
            ),
          ],
        ),
        myDivider(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "${exitSelectedDate.toLocal()}".split(' ')[0],
              style: kHeaderTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectExitDate(context);
                });
              }, // Refer step 3
              child: Text(
                'Select Exit date',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              //color: Colors.greenAccent,
            ),
          ],
        ),
        SizedBox(height: 20,),
        Divider(
            endIndent: 1,
            indent: 1,
            color: Colors.black
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text("Number of Passengers : " ,
            style: kHeaderTextStyle,
          ),
        ),

        Container(
          //width: size.width * 0.35,
          child: Row(
            children: [
              MyCircleButton(
                onPressed: (){
                  setState(() {
                    numPassengers++;
                  });
                },
                iconData: FontAwesomeIcons.plus,
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                numPassengers.toString() ?? 'text',
                style: kHeaderTextStyle.copyWith(
                  color: Colors.blueGrey,
                ),
              ),
              Spacer(
                flex: 1,
              ),
              MyCircleButton(
                onPressed: (){
                  setState(() {
                    numPassengers--;
                  });
                },
                iconData: FontAwesomeIcons.minus,
              ),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: onContinue,
            child: Text("Complete Reservation"))


      ],
    );
  }

  _selectEntryDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: entrySelectedDate, // Refer step 1
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != entrySelectedDate)
      setState(() {
        entrySelectedDate = picked;
      });
  }

  _selectExitDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: exitSelectedDate, // Refer step 1
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != exitSelectedDate)
      setState(() {
        exitSelectedDate = picked;
      });
  }

  bool ValidationReserve(){
    return true;
  }

  void onContinue(){
    if(ValidationReserve())
      PostReserve();
  }



  Future PostReserve() async{
    Map map = Map();

    map['villa'] = widget.myVilla.id;
    map['start_date'] = entrySelectedDate.toString();
    map['end_date'] = exitSelectedDate.toString();
    map['num_of_passengers'] = numPassengers;
    map['total_cost'] = (widget.myVilla.price * (exitSelectedDate.difference(entrySelectedDate).inDays)).toString();



    final response = await http.post(
      Uri.parse('$mainUrl/api/villa/user/register/'),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
        // HttpHeaders.authorizationHeader: 'Token bab330f8321c61a9ba457fab4efc1b223c3f8731',
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: convert.jsonEncode(map),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Villa.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}



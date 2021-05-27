import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/components/circle_button.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/screens/detailVilla/components/myDivider.dart';

DateTime entrySelectedDate = DateTime.now();
DateTime exitSelectedDate = DateTime.now();
int numPassengers = 1;

class reserveVilla extends StatefulWidget {
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
              onPressed: () => _selectEntryDate(context), // Refer step 3
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
              "${entrySelectedDate.toLocal()}".split(' ')[0],
              style: kHeaderTextStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () => _selectExitDate(context), // Refer step 3
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
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}



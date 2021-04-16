import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/screens/authentication/components/confirm_button.dart';
import 'package:loctio_booker/screens/authentication/components/my_textfield.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../../constants.dart';
import 'dart:async';
import 'dart:io';

class facility_villa extends StatefulWidget {
  static String id = 'facility_villa';

  @override
  _facility_villaState createState() => _facility_villaState();
}

class _facility_villaState extends State<facility_villa> {
  FocusNode node;
  Color color = Colors.black;
  //String sendEmailUrl = '$mainUrl/api/account/send-email';
  TextEditingController capacityController;
  TextEditingController roomsController;
  TextEditingController singleBedsController;
  TextEditingController doubleBedsController;
  TextEditingController showersController;
  TextEditingController WcController;
  File _image;

  int capacity =0;
  int rooms = 0;
  int singleBeds = 0;
  int doubleBeds = 0;
  int showers = 0;
  int wc = 0;
  Size size;
  String country, token;
  Map args;

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //print('e: ${widget.user.email}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter your Facilities',
          style: kBodyTextStyle.copyWith(
            color: Colors.white
          ),
        ),
      ),
      body: ModalProgressHUD(
        progressIndicator: kMyProgressIndicator,
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),

                Text(
                  'Base Capacity',
                  style: kBodyTextStyle.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20 , right: 20 , top: 10),
                  child: NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    min: 0,
                    onIncrement: (num newnumber){
                      setState(() {
                        capacity = newnumber;
                        print('new capacity is $capacity');
                      });
                    },
                    onDecrement: (num newnumber){
                      setState(() {
                        capacity = newnumber;
                        print('new capacity is $capacity');
                      });

                    },

                  ),
                ),

                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  'Number of rooms',
                  style: kBodyTextStyle.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20 , right: 20 , top: 10),
                  child: NumberInputWithIncrementDecrement(
                  controller: TextEditingController(),
                  min: 0,
                    onIncrement: (num newnumber){
                      setState(() {
                        rooms = newnumber;
                        print('new capacity is $rooms');
                      });
                    },
                    onDecrement: (num newnumber){
                      setState(() {
                        rooms = newnumber;
                        print('new capacity is $rooms');
                      });

                    },
              ),
                ),

                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  'Number of Single_Beds',
                  style: kBodyTextStyle.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20 , right: 20 , top: 10),
                  child: NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    min: 0,
                    onIncrement: (num newnumber){
                      setState(() {
                        singleBeds = newnumber;
                        print('new capacity is $singleBeds');
                      });
                    },
                    onDecrement: (num newnumber){
                      setState(() {
                        singleBeds = newnumber;
                        print('new capacity is $singleBeds');
                      });

                    },
                  ),
                ),

                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  'Number of double_beds',
                  style: kBodyTextStyle.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20 , right: 20 , top: 10),
                  child: NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    min: 0,
                    onIncrement: (num newnumber){
                      setState(() {
                        doubleBeds = newnumber;
                        print('new capacity is $doubleBeds');
                      });
                    },
                    onDecrement: (num newnumber){
                      setState(() {
                        doubleBeds = newnumber;
                        print('new capacity is $doubleBeds');
                      });

                    },
                  ),
                ),

                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  'Number of showers',
                  style: kBodyTextStyle.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20 , right: 20 , top: 10),
                  child: NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    min: 0,
                    onIncrement: (num newnumber){
                      setState(() {
                        showers = newnumber;
                        print('new capacity is $showers');
                      });
                    },
                    onDecrement: (num newnumber){
                      setState(() {
                        showers = newnumber;
                        print('new capacity is $showers');
                      });

                    },
                  ),
                ),

                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  'Number of WC',
                  style: kBodyTextStyle.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20 , right: 20 , top: 10),
                  child: NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    min: 0,
                    onIncrement: (num newnumber){
                      setState(() {
                        wc = newnumber;
                        print('new capacity is $wc');
                      });
                    },
                    onDecrement: (num newnumber){
                      setState(() {
                        wc = newnumber;
                        print('new capacity is $wc');
                      });

                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),

                MyConfirmButton(
                  size: size,
                  onPressed: () {
                    onContinuePressed();
                  },
                  text: 'Continue',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onContinuePressed() {

  }


}

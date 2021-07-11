import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/components2/detail_divider.dart';
import 'package:loctio_booker/screens/detailVilla/reserver_components/payment_dialog.dart';
import 'package:loctio_booker/screens/detailVilla/reserver_components/reserve_send_button.dart';
import 'package:loctio_booker/screens/detailVilla/reserver_components/villa_reserve_header.dart';
import 'package:loctio_booker/static_methods.dart';
import '../../constants.dart';
import '../payment/payment_screen.dart';
import 'reserver_components/reserve_date.dart';
import 'reserver_components/reserve_no_people.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../models/user.dart';

class ReserveScreen extends StatefulWidget {
  final Villa villa;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final User user;

  int totalCost;

  ReserveScreen({
    this.villa,
    this.imageUrl,
    this.endDate,
    this.startDate,
    this.totalCost,
    this.user,
  });

  @override
  _ReserveScreenState createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  int count = 1;
  Size size;
  bool isActivated = false;
  int totalCost = 0;
  String addVillaUrl = '$mainUrl/api/villa/user/register/';

  @override
  Widget build(BuildContext context) {
    print('*******************************************');
    print(widget.startDate);
    print(widget.endDate);
    print('*******************************************');
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Send reserve request',
          style: kBody2TextStyle.copyWith(
            color: Colors.blueGrey[800],
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.blueGrey[800],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ReserveHeader(
                    villa: widget.villa,
                    imageUrl: widget.imageUrl,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DetailDivider(),
                  ReserveDate(
                    startDate: widget.startDate,
                    endDate: widget.endDate,
                  ),
                  DetailDivider(),
                  ReserveNoPeople(
                    count: count,
                    size: size,
                    decrease: () {
                      onDecrease();
                    },
                    increase: () {
                      onIncrease();
                    },
                    isActivated: isActivated,
                  ),
                  DetailDivider(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          DetailDivider(),
          ReserveSendButton(
            villa: widget.villa,
            cost: getCost(),
            onReservePressed: () {
              onReservedPressed();
            },
          ),
        ],
      ),
    );
  }

  onReservedPressed() async {
    Map map = Map();
    print('------------------------');
    print(widget.villa.villaId);
    print(widget.startDate.toString().substring(0, 10));
    print(widget.endDate.toString().substring(0, 10));
    print('------------------------');
    map['start_date'] = widget.startDate.toString().substring(0, 10);
    map['end_date'] = widget.endDate.toString().substring(0, 10);
    map['villa_id'] = widget.villa.villaId;
    map['num_of_passengers'] = count;
    map['total_cost'] = widget.totalCost;
    map['villa'] = widget.villa.villaId;
    http.Response response = await http.post(
      Uri.parse(addVillaUrl),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: convert.json.encode(map),
    );
    if (response.statusCode < 400) {
      print(response.body);
      StaticMethods.showSuccessDialog(context, 'Villa Reserved');
    } //
    else {
      print('-------- ******************');
      print(response.statusCode);
      print(response.body);
      print('-------- ******************');
      StaticMethods.showErrorDialog(context, 'Failed to Reserve Villa !');
    }
  }

  onIncrease() {
    setState(() {
      ++count;
      isActivated = true;
      totalCost += widget.villa.price;
    });
  }

  onDecrease() {
    setState(() {
      --count;
      if (count <= 1) {
        print('deActive');
        isActivated = false;
        // pass
      } else {
        print('active');
        isActivated = true;
        totalCost -= widget.villa.price;
      }
    });
  }

  String getCost() {
    int price =
        widget.endDate.difference(widget.startDate).inDays * widget.villa.price;
    return price.toString();
  }

  void showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return PaymentDialog();
      },
    );
  }
}

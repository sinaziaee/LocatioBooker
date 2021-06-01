import 'package:flutter/material.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/components2/detail_divider.dart';
import 'package:loctio_booker/screens/detailVilla/reserver_components/reserve_send_button.dart';
import 'package:loctio_booker/screens/detailVilla/reserver_components/villa_reserve_header.dart';

import '../../constants.dart';
import 'components2/reserve_button.dart';
import 'reserver_components/reserve_date.dart';
import 'reserver_components/reserve_no_people.dart';

class ReserveScreen extends StatefulWidget {
  final Villa villa;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;

  int totalCost;

  ReserveScreen({
    this.villa,
    this.imageUrl,
    this.endDate,
    this.startDate,
    this.totalCost,
  });

  @override
  _ReserveScreenState createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  int count = 1;
  Size size;
  bool isActivated = false;
  int totalCost = 0;

  @override
  Widget build(BuildContext context) {
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
          ),
        ],
      ),
    );
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

  String getCost(){
    int price = widget.endDate.difference(widget.startDate).inDays * widget.villa.price;
    return price.toString();
  }

}

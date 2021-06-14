import 'package:flutter/material.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/reserve_date_screen.dart';

import '../../../constants.dart';

class ReserveSendButton extends StatefulWidget {
  final Villa villa;
  final String cost;

  ReserveSendButton({
    @required this.villa,
    @required this.cost,
  });

  @override
  _ReserveSendButtonState createState() => _ReserveSendButtonState();
}

class _ReserveSendButtonState extends State<ReserveSendButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: 15,
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                '  Total Price',
                style: kBody2TextStyle.copyWith(
                  color: Colors.blueGrey[900],
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              Text(
                // '${villa.rate ?? 4.0}',
                '    ${widget.cost} dollars',
                style: kBody2TextStyle.copyWith(
                  color: Colors.blueGrey[900],
                  fontSize: 16,
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          Spacer(),
          Material(
            borderRadius: BorderRadius.circular(25),
            color: Colors.blueGrey[800],
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                onPressed();
              },
              child: Container(
                child: Text(
                  'Reserve',
                  style: kBody1TextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  // color: Colors.blueGrey[800],
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onPressed() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return ReserveDateScreen(
    //         villa: widget.villa,
    //         imageUrl: widget.cost,
    //       );
    //     },
    //   ),
    // );
  }
}

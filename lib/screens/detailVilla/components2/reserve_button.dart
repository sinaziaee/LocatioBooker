import 'package:flutter/material.dart';
import 'package:loctio_booker/models/villa.dart';

import '../../../constants.dart';

class ReserveButton extends StatefulWidget {
  final Villa villa;
  ReserveButton({this.villa});
  @override
  _ReserveButtonState createState() => _ReserveButtonState();
}

class _ReserveButtonState extends State<ReserveButton> {
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
              Row(
                children: [
                  Text(
                    '${widget.villa.price.toString()} dollars',
                    style: kBody2TextStyle.copyWith(
                      color: Colors.blueGrey[900],
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '/each night',
                    style: kBody2TextStyle.copyWith(
                      color: Colors.blueGrey[400],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    // '${villa.rate ?? 4.0}',
                    '${4.0}',
                    style: kBody2TextStyle.copyWith(
                      color: Colors.blueGrey[900],
                      fontSize: 16,
                    ),
                  ),
                ],
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
              onTap: (){
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

  onPressed(){
    setState(() {

    });
  }

}

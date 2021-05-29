import 'package:flutter/material.dart';
import 'package:loctio_booker/models/villa.dart';

import '../../../constants.dart';

class DetailHeader extends StatelessWidget {
  final Villa villa;

  DetailHeader({this.villa});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          villa.name,
          style: kBody1TextStyle.copyWith(
            color: Colors.blueGrey[800],
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              // Text(villa.rate),
              Text(
                '${0.4} ',
                style: kBody1TextStyle.copyWith(
                  color: Colors.blueGrey[800],
                  fontSize: 18,
                ),
              ),
              Icon(
                Icons.location_pin,
                color: Colors.yellow,
              ),
              Text(
                '${villa.country}, ${villa.state}, ${villa.city}',
                style: kBody1TextStyle.copyWith(
                  color: Colors.blueGrey[400],
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:loctio_booker/models/villa.dart';

import '../../../constants.dart';

class DetailServiceBody extends StatelessWidget {
  final Villa villa;

  DetailServiceBody({this.villa});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            villa.name,
            style: kBody1TextStyle.copyWith(
              color: Colors.blueGrey[800],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Hosting by ${villa.owner}',
            style: kBody1TextStyle.copyWith(
              color: Colors.blueGrey[800],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

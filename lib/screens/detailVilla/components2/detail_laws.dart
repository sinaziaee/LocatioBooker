import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/screens/detailVilla/components2/rule_date_item.dart';

class DetailLaws extends StatelessWidget {

  final Size size;

  DetailLaws({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Residence rules and regulations',
            style: kBody1TextStyle.copyWith(
              color: Colors.blueGrey[800],
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RuleDateItem(
                size: size,
                text: 'Entrance Time',
                time: '14:00',
              ),
              RuleDateItem(
                size: size,
                text: 'Exit Time',
                time: '12:00',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

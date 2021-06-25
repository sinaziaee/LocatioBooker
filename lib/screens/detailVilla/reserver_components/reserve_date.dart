import 'package:flutter/material.dart';
import 'package:loctio_booker/static_methods.dart';

import '../../../constants.dart';

class ReserveDate extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;

  ReserveDate({this.startDate, this.endDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(
          Icons.calendar_today,
          color: Colors.blueGrey[800],
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_right),
          color: Colors.blueGrey[700],
        ),
        title: Text(
          'Trip date',
          style: kBody1TextStyle.copyWith(
            color: Colors.blueGrey[700],
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
        subtitle: Text(
          '${StaticMethods.getMonthString(startDate.month)} ${startDate.day} to ${endDate.day} (${endDate.difference(startDate).inDays} nights)',
        ),
      ),
    );
  }
}

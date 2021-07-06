import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/reserve_date_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../models/user.dart';

class ReserveButton extends StatefulWidget {
  final Villa villa;
  final String imageUrl;
  final User user;
  final bool show;

  ReserveButton({
    @required this.villa,
    @required this.imageUrl,
    this.user,
    this.show,
  });

  @override
  _ReserveButtonState createState() => _ReserveButtonState();
}

class _ReserveButtonState extends State<ReserveButton> {
  bool showProgress = false;
  String calendarUrl = '$mainUrl/api/villa/calendar/show';

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showProgress,
      child: Container(
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
                      '${widget.villa.rate != null ? widget.villa.rate.toString() : 4.0}',
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
            if (widget.show == null || widget.show == true) ...[
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
            ] //
            else ...[
              Material(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blueGrey[400],
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
            ]
          ],
        ),
      ),
    );
  }

  Future<List<DateTime>> getOccupiedDates() async {
    print('$calendarUrl/?villa_id=${widget.villa.id}');
    http.Response response = await http.get(
      Uri.parse('$calendarUrl/?villa_id=${widget.villa.id}'),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
      },
    );
    if (response.statusCode < 400) {
      Map jsonResponse = convert.json.decode(response.body);
      List dateStringList = jsonResponse['dates'];
      List<DateTime> datetimeList = [];
      for (String each in dateStringList) {
        List date = each.split('-');
        datetimeList.add(
          DateTime(
            int.parse(date[0]),
            int.parse(date[1]),
            int.parse(date[2]),
          ),
        );
      }
      // print(datetimeList);
      return datetimeList;
    } //
    else {
      print('Error');
      // print(response.statusCode);
      // print(response.body);
      return null;
    }
  }

  onPressed() async {
    List<DateTime> dates = await getOccupiedDates();
    if (dates == null) {
      print('wrong');
      return;
    }
    DateTime before = DateTime.now();
    // List time = before.toString().split('-')6
    DateTime after = DateTime(before.year, before.month, before.day)
        .subtract(Duration(days: 30));
    // print(after);
    for (int i = 0; i <= 60; i++) {
      dates.add(after.add(Duration(days: i)));
    }
    print('--- *** ---');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ReserveDateScreen(
            villa: widget.villa,
            imageUrl: widget.imageUrl,
            dates: dates,
            user: widget.user,
          );
        },
      ),
    );
  }
}

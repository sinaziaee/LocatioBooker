import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/components2/detail_calendar.dart';
import 'package:loctio_booker/screens/detailVilla/reserve_screen.dart';
import 'package:loctio_booker/screens/detailVilla/reserver_components/button_select_date.dart';
import 'package:loctio_booker/screens/detailVilla/reserver_components/start_end_date.dart';
import '../../models/user.dart';

class ReserveDateScreen extends StatefulWidget {
  final Villa villa;
  final String imageUrl;
  List<DateTime> dates;
  final User user;

  ReserveDateScreen({
    this.villa,
    this.imageUrl,
    this.dates,
    this.user,
  });

  @override
  _ReserveDateScreenState createState() => _ReserveDateScreenState();
}

class _ReserveDateScreenState extends State<ReserveDateScreen> {
  Size size;
  bool isStart = true;
  bool isEnd = false;
  bool isReady = false;
  DateTime startDate, endDate;

  DatePeriod selectedPeriod = DatePeriod(
    DateTime.now().add(
      Duration(days: 1),
    ),
    DateTime.now().add(
      Duration(days: 3),
    ),
  );

  int count = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Select',
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
            Icons.clear,
            color: Colors.blueGrey[800],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: StartEndDate(
                size: size,
                isStart: isStart,
                isEnd: isEnd,
              ),
            ),
            DetailCalendar(
              dates: widget.dates,
              onSelectedDateChanged: (selectedPeriod) {
                onCalendarChanged(selectedPeriod);
              },
              selectedPeriod: selectedPeriod,
            ),
            ButtonSelectDate(
              isReady: isReady,
              onPressed: () {
                onPressed();
              },
            ),
          ],
        ),
      ),
    );
  }

  onCalendarChanged(DatePeriod newPeriod) {
    startDate = newPeriod.start;
    endDate = newPeriod.end;
    print('start: $startDate');
    print('end: $endDate');
    setState(
      () {
        this.selectedPeriod = newPeriod;
        isStart = !isStart;
        isEnd = !isEnd;
        count++;
        if (count % 3 == 0) {
          isReady = true;
        } else if (count % 3 == 1) {
          count++;
          // isReady = false;
          isReady = true;
        } else {
          // isReady = false;
          isReady = false;
        }
      },
    );
  }

  onPressed() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ReserveScreen(
              villa: widget.villa,
              endDate: endDate,
              startDate: startDate,
              imageUrl: widget.imageUrl,
              totalCost: widget.villa.price,
              user: widget.user,
            );
          },
        ),
      );
    });
  }
}

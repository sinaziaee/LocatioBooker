import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailTableCalendar extends StatefulWidget {

  const DetailTableCalendar({Key key}) : super(key: key);

  @override
  _DetailTableCalendarState createState() => _DetailTableCalendarState();
}

class _DetailTableCalendarState extends State<DetailTableCalendar> {
  DateTime _lastDate = DateTime.now().add(Duration(days: 345));

  List<DateTime> _dates = [];

  @override
  Widget build(BuildContext context) {
    _dates.clear();
    _dates.add(DateTime(2021, 5, 23));
    _dates.add(DateTime(2021, 5, 24));
    _dates.add(DateTime(2021, 5, 25));
    _dates.add(DateTime(2021, 5, 26));
    _dates.add(DateTime(2021, 5, 27));

    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      selectedDayPredicate: (val) {
        return _dates.contains(val);
      },
      enabledDayPredicate: (date){
        print(date);
        return true;
      },
      onDaySelected: (date1, date2){
        print('${date1.toString()} to ${date2.toString()}');
      },
    );
  }
}

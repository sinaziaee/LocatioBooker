import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class DetailRange extends StatefulWidget {
  @override
  _DetailRangeState createState() => _DetailRangeState();
}

class _DetailRangeState extends State<DetailRange> {
  DateTime _firstDate = DateTime.now().subtract(Duration(days: 345));

  // Set<String> unselectableDates = Set();
  DateTime _lastDate = DateTime.now().add(Duration(days: 345));
  List<DateTime> _dates = [];
  DatePeriod _selectedPeriod = DatePeriod(
    DateTime.now().subtract(
      Duration(days: 10),
    ),
    DateTime.now().subtract(
      Duration(days: 2),
    ),
  );

  Color selectedPeriodStartColor = Colors.redAccent;

  Color selectedPeriodLastColor = Colors.redAccent;

  Color selectedPeriodMiddleColor = Colors.redAccent;

  @override
  Widget build(BuildContext context) {
    // unselectableDates.clear();
    // // unselectableDates.add(DateTime.now().toString().substring(0, 10));
    // unselectableDates.add(DateTime(2021, 5, 31).toString());
    // unselectableDates.add(DateTime(2021, 6, 1).toString());
    // unselectableDates.add(DateTime(2021, 6, 2).toString());
    // unselectableDates.add(DateTime(2021, 6, 3).toString());
    _dates.clear();
    _dates.add(DateTime(2021, 5, 23));
    _dates.add(DateTime(2021, 5, 24));
    _dates.add(DateTime(2021, 5, 25));
    _dates.add(DateTime(2021, 5, 26));
    _dates.add(DateTime(2021, 5, 27));

    DatePickerRangeStyles styles = DatePickerRangeStyles(
        selectedPeriodLastDecoration: BoxDecoration(
            color: selectedPeriodLastColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0))),
        selectedPeriodStartDecoration: BoxDecoration(
          color: selectedPeriodStartColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              bottomLeft: Radius.circular(24.0)),
        ),
        selectedPeriodMiddleDecoration: BoxDecoration(
            color: selectedPeriodMiddleColor, shape: BoxShape.rectangle),
        nextIcon: const Icon(Icons.arrow_right),
        prevIcon: const Icon(Icons.arrow_left),
        dayHeaderStyleBuilder: _dayHeaderStyleBuilder);
    return Container(
      height: 250,
      child: Center(
        child: RangePicker(
          initiallyShowDate: DateTime.now(),
          // selectedPeriod: _selectedPeriod,
          selectedPeriod: DatePeriod(DateTime.now(), DateTime.now()),
          onChanged: _onSelectedDateChanged,
          firstDate: _firstDate,
          lastDate: _lastDate,
          datePickerStyles: styles,
          // selectableDayPredicate: (DateTime val) => !_dates.contains(val),
          selectableDayPredicate: (DateTime val) => !_dates.contains(val),

          // eventDecorationBuilder: _eventDecorationBuilder,
          // selectableDayPredicate: _isSelectableCustom,
          // onSelectionError: _onSelectionError,
        ),
      ),
    );
  }

  String sanitizeDateTime(DateTime dateTime) =>
      "${dateTime.year}-${dateTime.month}-${dateTime.day}";

  Set<String> getDateSet(List<DateTime> dates) =>
      dates.map(sanitizeDateTime).toSet();

  DayHeaderStyle _dayHeaderStyleBuilder(int weekday) {
    bool isWeekend = weekday == 0 || weekday == 6;

    return DayHeaderStyle(
        textStyle: TextStyle(color: isWeekend ? Colors.red : Colors.teal));
  }

  void _onSelectedDateChanged(DatePeriod newPeriod) {
    // setState(() {
    //   _selectedPeriod = newPeriod;
    // });
  }
}

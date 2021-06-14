import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class DetailCalendar extends StatefulWidget {
  final DatePeriod selectedPeriod;
  final List dates;
  final Function(DatePeriod selectedPeriod) onSelectedDateChanged;

  DetailCalendar({this.selectedPeriod, this.dates, this.onSelectedDateChanged});

  @override
  _DetailCalendarState createState() => _DetailCalendarState();
}

class _DetailCalendarState extends State<DetailCalendar> {
  DateTime _firstDate = DateTime.now().subtract(Duration(days: 345));
  DateTime _lastDate = DateTime.now().add(Duration(days: 345));

  final Color selectedPeriodStartColor = Colors.blueGrey;
  final Color selectedPeriodLastColor = Colors.blueGrey;
  final Color selectedPeriodMiddleColor = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
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
      height: 400,
      child: Center(
        child: RangePicker(
          initiallyShowDate: DateTime.now(),
          selectedPeriod: widget.selectedPeriod,
          // selectedPeriod: DatePeriod(DateTime.now(), DateTime.now()),
          onChanged: widget.onSelectedDateChanged,
          firstDate: _firstDate,
          lastDate: _lastDate,
          datePickerStyles: styles,
          // selectableDayPredicate: (DateTime val) => !_dates.contains(val),
          selectableDayPredicate: (DateTime val) => !widget.dates.contains(val),
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
      textStyle: TextStyle(color: isWeekend ? Colors.redAccent : Colors.teal),
    );
  }
}

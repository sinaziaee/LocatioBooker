import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/home/result_screen.dart';
import 'package:loctio_booker/static_methods.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:opencage_geocoder/opencage_geocoder.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:latlong/latlong.dart' as latLng;

class DatePickerScreen extends StatefulWidget {
  final User user;
  final Key key = Key('date_picker_screen');
  final String city;

  DatePickerScreen({this.user, this.city});

  @override
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  bool showSpinner = false;
  String url = '$mainUrl/api/villa/search/?number_of_villa=10&page=1';
  latLng.LatLng location;

  @override
  Widget build(BuildContext context) {
    url = '$url&city=${widget.city}';
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 25,
            color: Colors.black,
          ),
        ),
        title: Text(
          'You can select start and end dates',
          style: kBody2TextStyle.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: kMyProgressIndicator,
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: SfDateRangePicker(
                  startRangeSelectionColor: Colors.blue[400],
                  endRangeSelectionColor: Colors.blue[900],
                  rangeSelectionColor: Colors.blue[100],
                  showActionButtons: true,
                  showNavigationArrow: true,
                  cancelText: 'Pass',
                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: kBody1TextStyle.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  confirmText: 'Submit',
                  onCancel: () async {
                    Map map = await getPlacesInfo([]);
                    if (map == null) {
                      StaticMethods.showErrorDialog(
                          context, 'An Error occurred');
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ResultScreen(
                            user: widget.user,
                            map: map,
                            location: location,
                            city: widget.city,
                          );
                        },
                      ),
                    );
                  },
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs date) {
                  },
                  onSubmit: (dateR) async {
                    String dateRange = dateR.toString();
                    List<String> dateList = datePickerSplitter(dateRange);
                    Map map = await getPlacesInfo(dateList);
                    if (map == null) {
                      StaticMethods.showErrorDialog(
                          context, 'An Error occurred');
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ResultScreen(
                            user: widget.user,
                            map: map,
                            location: location,
                            city: widget.city,
                            startDate: dateList[0],
                            endDate: dateList[1],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> datePickerSplitter(String dateRange) {
    int startIndex = dateRange.indexOf('startDate');
    dateRange = dateRange.substring(startIndex);
    List<String> stringList = dateRange.split(',');
    List<String> start = stringList[0].split(': ');
    List<String> end = stringList[1].split(': ');
    String startDate = start[1].substring(0, 10);
    String endDate = end[1].substring(0, 10);
    return [startDate, endDate];
  }

  Future<Map> getPlacesInfo(List<String> dateList) async {
    setState(() {
      showSpinner = true;
    });

    Coordinates response =
        await StaticMethods.getLocation(context, widget.city, null, null);
    location = latLng.LatLng(response.latitude, response.longitude);
    if (dateList == null || dateList.length == 0) {
      try {
        http.Response response = await http.get(
          Uri.parse('$url'),
          headers: {
            HttpHeaders.authorizationHeader: widget.user.token,
          },
        );
        if (response.statusCode >= 400) {
          setState(() {
            showSpinner = false;
          });
          return null;
        }
        Map jsonResponse = convert.json.decode(response.body);
        setState(() {
          showSpinner = false;
        });
        return jsonResponse;
      } catch (e) {
        print('$e');
        setState(() {
          showSpinner = false;
        });
        return null;
      }
    }
    try {
      http.Response response = await http.get(
        Uri.parse('$url&start_date=${dateList[0]}&end_date=${dateList[1]}'),
        headers: {
          HttpHeaders.authorizationHeader: widget.user.token,
        },
      );
      if (response.statusCode >= 400) {
        setState(() {
          showSpinner = false;
        });
        return null;
      }
      Map jsonResponse = convert.json.decode(convert.utf8.decode(response.bodyBytes));
      setState(() {
        showSpinner = false;
      });
      return jsonResponse;
    } catch (e) {
      print('$e');
      setState(() {
        showSpinner = false;
      });
      return null;
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';

class RateDialog extends StatefulWidget {
  final int villaId;
  final User user;

  RateDialog({
    this.villaId,
    this.user,
  });

  @override
  _RateDialogState createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {

  double rate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('Rate villa'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RatingBar(
            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star,
                color: Colors.yellow[800],
              ),
              half: Icon(
                Icons.star_half,
                color: Colors.yellow[800],
              ),
              empty: Icon(
                Icons.star_border_outlined,
                color: Colors.yellow[800],
              ),
            ),
            onRatingUpdate: (rate) {
              this.rate = rate;
              print(rate);
            },
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              print('$mainUrl/api/villa/rate/add/');
              http.Response response = await http.post(
                Uri.parse('$mainUrl/api/villa/rate/add/'),
                body: convert.json.encode(
                  {
                    'villa_id': widget.villaId,
                    'rate': rate,
                  },
                ),
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                  HttpHeaders.authorizationHeader: widget.user.token,
                },
              );
              print(response.body);
              if (response.statusCode < 400) {
                setState(() {});
                Navigator.pop(context);
              } //
              else {
                print(
                    '========================================================');
                print(response.statusCode);
                print(
                    '========================================================');
              }
            },
            child: Text('Submit'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.blueGrey,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              elevation: MaterialStateProperty.all(0),
            ),
          ),
        ],
      ),
    );
  }
}

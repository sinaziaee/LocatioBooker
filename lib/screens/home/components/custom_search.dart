import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';

class CustomSearch extends StatelessWidget {
  final Size size;
  final Function onPressed;

  CustomSearch({this.size, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          child: Container(
            width: size.width * 0.8,
            height: 90,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tell us where:',
                  style: kHeaderTextStyle.copyWith(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Country',
                      style: kBody3TextStyle.copyWith(),
                    ),
                    Text(
                      'State',
                      style: kBody3TextStyle.copyWith(),
                    ),
                    Text(
                      'City',
                      style: kBody3TextStyle.copyWith(),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.lightBlue,
                      radius: 16,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

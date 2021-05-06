import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';

class CustomProfileNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            child: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/unknown_person.png',
              ),
              backgroundColor: Colors.white,
              radius: 100,
            ),
            backgroundColor: Colors.lightBlue,
            radius: 105,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Profile Not found',
            style: kHeaderTextStyle.copyWith(),
          ),
        ],
      ),
    );
  }
}

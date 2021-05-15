import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomProfileSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            child: CircleAvatar(
              child: Icon(
                Icons.search,
                size: 130,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              radius: 100,
            ),
            backgroundColor: Colors.black,
            radius: 105,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Search for profiles',
            style: kHeaderTextStyle.copyWith(),
          ),
        ],
      ),
    );
  }
}

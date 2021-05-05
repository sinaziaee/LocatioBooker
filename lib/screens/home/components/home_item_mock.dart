import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/search_model.dart';
import '../../../constants.dart';


class HomePlaceItemMock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[100],
      ),
      width: 220,
      height: 150,
      margin: EdgeInsets.only(
        left: 20,
        right: 5,
        top: 5,
        bottom: 5,
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
        ),
      ),
    );
  }
}

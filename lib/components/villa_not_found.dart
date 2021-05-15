import 'package:flutter/material.dart';

import '../constants.dart';


class VillaNotFound
    extends StatelessWidget {

  final Size size;
  VillaNotFound({@required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/images/resort/no_house.jpg',
            height: size.height * 0.25,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'No Villa/Resort found',
            style: kBodyTextStyle.copyWith(fontSize: size.width * 0.036),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

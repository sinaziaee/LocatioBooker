import 'package:flutter/material.dart';

import '../../../constants.dart';

class ApartmentNotFoundComponent extends StatelessWidget {

  final Size size;
  ApartmentNotFoundComponent({@required this.size});

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
            'Register your accommodation, villa, suite or apartment.',
            style: kBodyTextStyle.copyWith(fontSize: size.width * 0.036),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            'Your registered accommodations will be shown here.',
            style: kBodyTextStyle.copyWith(
              fontSize: size.width * 0.033,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

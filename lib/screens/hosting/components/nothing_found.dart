import 'package:flutter/material.dart';

import '../../../constants.dart';

class NothingFound extends StatelessWidget {
  final Size size;
  final String image;
  final String text1;
  final String text2;

  NothingFound({
    @required this.size,
    @required this.image,
    this.text1,
    this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            // 'assets/images/resort/no_house.jpg',
            image,
            height: size.height * 0.25,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text1 ?? 'Register your accommodation, villa, suite or apartment.',
            style: kBodyTextStyle.copyWith(fontSize: size.width * 0.036),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            text2 ?? 'Your registered accommodations will be shown here.',
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

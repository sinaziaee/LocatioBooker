import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../../constants.dart';

class HelpItem extends StatelessWidget {
  final String imageAsset;
  final String text, buttonText;
  final Size size;

  HelpItem({
    this.text,
    this.buttonText,
    this.imageAsset,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      padding: EdgeInsets.only(
        top: 20,
        bottom: 10,
        left: 5,
        right: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.5,
          color: Colors.blueGrey,
        ),
      ),
      width: size.width * 0.45,
      height: size.height * 0.33,
      child: Column(
        children: [
          Image.asset(
            imageAsset,
            width: size.width * 0.35,
            height: size.width * 0.3,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: kBody3TextStyle.copyWith(),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            child: Center(
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: kBody3TextStyle.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

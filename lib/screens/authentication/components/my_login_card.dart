import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../login_screen.dart';

class LoginCard extends StatelessWidget {
  final String imageAsset;
  final Color color;
  final Color borderColor;
  final Function onTapped;
  final String text;
  LoginCard({this.text, this.imageAsset, this.color, this.borderColor, this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: LoginScreen.size.width * 0.06),
      height: LoginScreen.size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
        border: Border.all(
          color: borderColor,
          width: 0.5,
        ),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTapped,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: LoginScreen.size.height * 0.06,
            child: Row(
              children: [
                SizedBox(
                  width: LoginScreen.size.width * 0.05,
                ),
                Image.asset(
                  imageAsset,
                  height: 25,
                  width: 25,
                ),
                Spacer(),
                Text(
                  text,
                  style: kBodyTextStyle.copyWith(
                    color: borderColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';

class HostingResortItem extends StatelessWidget {
  final Size size;
  final String assetName, title;
  final Function onPressed;

  HostingResortItem({this.size, this.assetName, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    if(size.height > size.width){
      return Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Container(
            width: size.width * 0.45,
            height: size.height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    assetName,
                    fit: BoxFit.cover,
                    width: size.width * 0.4,
                    height: size.height * 0.2,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  title,
                  style: kBodyTextStyle.copyWith(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }
    else{
      return Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Container(
            width: size.width * 0.31,
            height: size.height * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    assetName,
                    fit: BoxFit.cover,
                    width: size.width * 0.3,
                    height: size.height * 0.5,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  title,
                  style: kBodyTextStyle.copyWith(
                    fontSize: size.width * 0.02,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

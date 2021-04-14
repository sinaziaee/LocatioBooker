import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';

class HostingCategoryItem extends StatelessWidget {
  final Size size;
  final String assetName, title;
  final Function onPressed;

  HostingCategoryItem({this.size, this.assetName, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: Container(
          width: size.width * 0.3,
          height: size.height * 0.17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width * 0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                assetName,
                height: size.height * 0.12,
                width: size.width * 0.15,
              ),
              Text(
                title,
                style: kBodyTextStyle.copyWith(
                  fontSize: 13,
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

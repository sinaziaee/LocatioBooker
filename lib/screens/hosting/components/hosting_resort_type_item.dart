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
    return Material(
      borderRadius: BorderRadius.circular(size.height * 0.05),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: Container(
          width: size.width * 0.4,
          height: size.height * 0.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width * 0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  assetName,

                  width: size.width * 0.3,
                  height: size.height * 0.16,
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
}

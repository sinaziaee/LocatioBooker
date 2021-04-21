import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ImageContainer extends StatelessWidget {
  final Function onImageSelectPressed;
  final Size size;
  final String headerText, bodyText;
  final double height, width;
  final IconData iconData;

  ImageContainer(
      {this.iconData,
      this.height,
      this.width,
      this.onImageSelectPressed,
      this.size,
      this.bodyText,
      this.headerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Material(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onImageSelectPressed,
              child: DottedBorder(
                radius: Radius.circular(20),
                dashPattern: [8, 2],
                borderType: BorderType.RRect,
                child: Container(
                  // margin: EdgeInsets.all(20),
                  height: height ?? size.height * 0.4,
                  width: width ?? size.height * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        (iconData != null) ? iconData : Icons.add_a_photo,
                        color: Colors.blueGrey[400],
                        size: size.height * 0.1,
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          headerText,
                          style: kBodyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        bodyText,
                        style: kBodyTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';

class Item extends StatelessWidget {
  final bool isSelected;
  final String asset;
  final Size size;
  final String text;
  final Function onTapped;

  Item({this.isSelected, this.onTapped, this.text, this.asset, this.size});

  @override
  Widget build(BuildContext context) {
    if (isSelected == true) {
      return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTapped,
        child: Container(
          // height: size.height * 0.1,
          height: 90,
          width: size.width * 0.28,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 2,
                top: 2,
                child: Icon(
                  Icons.clear,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      asset,
                      // height: size.height * 0.06,
                      height: 50,
                      width: size.width * 0.14,
                    ),
                    Text(
                      text ?? 'text',
                      style: kHeaderTextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTapped,
        child: Container(
          // height: size.height * 0.1,
          height: 90,
          width: size.width * 0.28,
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                asset,
                // height: size.height * 0.06,
                height: 50,
                width: size.width * 0.14,
              ),
              Text(
                text ?? 'text',
                style: kHeaderTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
  }
}

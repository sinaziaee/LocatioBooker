import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomHomeSearchBar extends StatelessWidget {

  final Size size;
  final Function onSearchPressed;

  CustomHomeSearchBar({this.size, this.onSearchPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(
        right: size.width * 0.1,
        left: size.width * 0.1,
        top: 0,
      ),
      child: GestureDetector(
        onTap: onSearchPressed,
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            enabledBorder: kOutLineInputBorder.copyWith(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            disabledBorder: kOutLineInputBorder.copyWith(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            focusedBorder: kOutLineInputBorder.copyWith(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: onSearchPressed,
            ),
            hintText: 'Search',
            contentPadding: EdgeInsets.only(
              bottom: 20,
              left: 10,
            ),
          ),
          cursorColor: Colors.black,
        ),
      ),
    );
  }
}

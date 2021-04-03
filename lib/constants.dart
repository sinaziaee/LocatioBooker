import 'package:flutter/material.dart';

final kOutLineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
);

final kHeaderTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

final kBodyTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

final kMyProgressIndicator = Container(
  height: 70,
  width: 70,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey,
  ),
  child: Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    ),
  ),
);

final String mainUrl = 'https://softcheetahs.herokuapp.com';
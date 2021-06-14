import 'package:flutter/material.dart';

class DetailDivider extends StatelessWidget {
  const DetailDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: 20,
      endIndent: 20,
      thickness: 1.5,
    );
  }
}

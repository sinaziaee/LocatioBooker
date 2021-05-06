import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderAlertDialog extends StatelessWidget {
  final String gender;
  final Function malePressed, femalePressed;

  GenderAlertDialog({this.gender, this.malePressed, this.femalePressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('Select Gender'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GenderItem(
            gender: 'Male',
            onTapped: malePressed,
          ),
          SizedBox(
            height: 20,
          ),
          GenderItem(
            gender: 'Female',
            onTapped: femalePressed,
          ),
        ],
      ),
    );
  }
}

class GenderItem extends StatelessWidget {
  final String gender;
  final Function onTapped;

  GenderItem({this.onTapped, this.gender});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          children: [
            Icon(FontAwesomeIcons.female),
            SizedBox(
              width: 20,
            ),
            Text(gender),
          ],
        ),
      ),
    );
  }
}
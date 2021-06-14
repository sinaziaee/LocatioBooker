import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants.dart';
import '../../../static_methods.dart';
import '../../../components/circle_button.dart';

class ReserveNoPeople extends StatelessWidget {
  final int count;
  final Function increase, decrease;
  final Size size;
  final bool isActivated;

  ReserveNoPeople({
    this.count,
    this.decrease,
    this.increase,
    this.size,
    this.isActivated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(
          Icons.people,
          color: Colors.blueGrey[800],
        ),
        trailing: Container(
          width: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyCircleButton(
                onPressed: increase,
                size: size,
                isActivated: true,
                iconData: FontAwesomeIcons.plus,
              ),
              Text(
                '  $count  ',
                style: kBody1TextStyle.copyWith(
                  color: Colors.blueGrey[800],
                  fontSize: 18,
                ),
              ),
              MyCircleButton(
                onPressed: decrease,
                size: size,
                isActivated: isActivated,
                iconData: FontAwesomeIcons.minus,
              ),
            ],
          ),
        ),
        title: Text(
          'Number of people',
          style: kBody1TextStyle.copyWith(
            color: Colors.blueGrey[700],
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
        subtitle: Text(
          '$count people',
        ),
      ),
    );
  }
}

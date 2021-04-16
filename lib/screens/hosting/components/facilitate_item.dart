import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/constants.dart';
import '../../../components/circle_button.dart';

class FacilitateItem extends StatelessWidget {
  final String text;
  final int count;
  final Function onIncrease, onDecrease;
  final Size size;

  FacilitateItem({this.size, this.text, this.count, this.onDecrease, this.onIncrease});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            text ?? 'text',
            style: kBodyTextStyle.copyWith(
              color: Colors.blueGrey[800],
            ),
          ),
          Spacer(
            flex: 5,
          ),
          Container(
            width: size.width * 0.35,
            child: Row(
              children: [
                MyCircleButton(
                  onPressed: onIncrease,
                  iconData: FontAwesomeIcons.plus,
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  count.toString() ?? 'text',
                  style: kHeaderTextStyle.copyWith(
                    color: Colors.blueGrey,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                MyCircleButton(
                  onPressed: onDecrease,
                  iconData: FontAwesomeIcons.minus,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

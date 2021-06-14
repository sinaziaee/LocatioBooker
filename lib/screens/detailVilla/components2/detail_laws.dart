import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/components2/rule_date_item.dart';

class DetailLaws extends StatelessWidget {
  final Size size;

  // final List<String> rulesList;

  final Villa villa;
  final List<String> fixedRules;

  DetailLaws({
    this.size,
    this.villa,
    this.fixedRules,
  });

  @override
  Widget build(BuildContext context) {
    print(fixedRules);
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Residence rules and regulations',
            style: kBody1TextStyle.copyWith(
              color: Colors.blueGrey[800],
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RuleDateItem(
                size: size,
                text: 'Entrance Time',
                time: '14:00',
              ),
              RuleDateItem(
                size: size,
                text: 'Exit Time',
                time: '12:00',
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          for (int i = 0; i < villa.rules.length; i++) ...[
            Row(
              children: [
                Icon(
                  Icons.adjust_outlined,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    // fixedRules[i],
                    villa.rules[i],
                    style: kBody2TextStyle.copyWith(),
                  ),
                ),
              ],
            ),
          ],
          // SizedBox(
          //   height: 10,
          // ),
          for (int i = 0; i < villa.rules.length; i++) ...[
            Row(
              children: [
                Icon(
                  Icons.done,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    villa.rules[i],
                    style: kBody2TextStyle.copyWith(),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

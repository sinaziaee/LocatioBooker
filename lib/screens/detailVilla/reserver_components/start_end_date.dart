import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';

class StartEndDate extends StatelessWidget {
  final Size size;
  final bool isStart;
  final bool isEnd;

  StartEndDate({
    this.size,
    this.isStart,
    this.isEnd,
  });

  double width;

  @override
  Widget build(BuildContext context) {
    width = size.width * 0.4;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isStart) ...[
            Container(
              height: 80,
              width: width,
              decoration: leftDecoration.copyWith(
                color: Colors.blueGrey[800],
              ),
              child: Center(
                child: Text(
                  'Start Date',
                  style: kBody1TextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ] else ...[
            Container(
              height: 80,
              width: width,
              decoration: leftDecoration.copyWith(
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Start Date',
                  style: kBody1TextStyle.copyWith(
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
          if (isEnd) ...[
            Container(
              height: 80,
              width: width,
              decoration: rightDecoration.copyWith(
                color: Colors.blueGrey[800],
              ),
              child: Center(
                child: Text(
                  'End Date',
                  style: kBody1TextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ] else ...[
            Container(
              height: 80,
              width: width,
              decoration: rightDecoration.copyWith(
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'End Date',
                  style: kBody1TextStyle.copyWith(
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:loctio_booker/models/villa.dart';

import '../../../constants.dart';

class DetailHeader extends StatelessWidget {
  final Villa villa;
  final bool visible;
  final Function onRatePressed;

  DetailHeader({
    this.villa,
    this.visible,
    this.onRatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.title,
                    color: Colors.yellow[700],
                  ),
                  Text(
                    ' ${villa.name}',
                    style: kBody1TextStyle.copyWith(
                      color: Colors.blueGrey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    // Text(villa.rate),
                    Text(
                      '${villa.rate ?? 4.0} ',
                      style: kBody1TextStyle.copyWith(
                        color: Colors.blueGrey[800],
                        fontSize: 18,
                      ),
                    ),
                    Icon(
                      Icons.location_pin,
                      color: Colors.red,
                    ),
                    Text(
                      '${villa.country}, ${villa.state}, ${villa.city}',
                      style: kBody1TextStyle.copyWith(
                        color: Colors.blueGrey[400],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: visible,
          child: Positioned(
            top: 10,
            right: 10,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(0.1),
              child: Container(
                width: 65,
                height: 20,
                child: ElevatedButton(
                  onPressed: onRatePressed,
                  child: Text('Rate'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blueGrey,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

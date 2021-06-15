import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/models/villa.dart';

import '../../../constants.dart';

class DetailServiceBody extends StatelessWidget {
  final Villa villa;
  final Function onChatPressed;

  DetailServiceBody({
    this.villa,
    this.onChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      villa.name,
                      style: kBody1TextStyle.copyWith(
                        color: Colors.blueGrey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Hosting by ${villa.owner}',
                      style: kBody1TextStyle.copyWith(
                        color: Colors.blueGrey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                child: IconButton(
                  iconSize: 40,
                  icon: Icon(
                    FontAwesomeIcons.telegram,
                    color: Colors.blue,
                  ),
                  onPressed: onChatPressed,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

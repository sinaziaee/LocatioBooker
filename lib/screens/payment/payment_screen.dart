import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'components/body_container.dart';

class PaymentScreen extends StatelessWidget {
  final User user;
  final Villa villa;
  final int cost;

  PaymentScreen({
    this.villa,
    this.user,
    this.cost,
  });

  Size size;
  bool showProgressBar = false;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    print(cost);
    return ModalProgressHUD(
      progressIndicator: kMyProgressIndicator,
      inAsyncCall: showProgressBar,
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Stack(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.3,
                    ),
                    height: size.height * 0.7,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: BodyContainer(cost, user, villa.villaId),
                  ),
                ],
              ),
            ),
            Positioned(
              left: size.width * 0.15,
              top: size.height * 0.2,
              child: Container(
                width: size.width * 0.7,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'PayPal',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: 15,
              child: SafeArea(
                child: Material(
                  color: Colors.white,
                  shape: CircleBorder(),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

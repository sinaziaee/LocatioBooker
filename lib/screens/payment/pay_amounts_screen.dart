import 'package:flutter/material.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/payment/components/pay_button.dart';
import 'package:loctio_booker/screens/payment/components/pay_item.dart';
import 'package:loctio_booker/screens/payment/components/pay_text.dart';
import 'package:loctio_booker/screens/payment/components/pay_textfield.dart';
import 'package:loctio_booker/screens/payment/payment_screen.dart';

import '../../constants.dart';

class PayAmountScreen extends StatefulWidget {
  final User user;

  PayAmountScreen(
    this.user,
  );

  @override
  _PayAmountScreenState createState() => _PayAmountScreenState();
}

class _PayAmountScreenState extends State<PayAmountScreen> {
  int cost = 0;

  TextEditingController controller;
  Size size;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            PayItem(
                              cost: 10,
                              onPressed: () {
                                onPayPressed(10);
                              },
                            ),
                            PayItem(
                              cost: 50,
                              onPressed: () {
                                onPayPressed(50);
                              },
                            ),
                            PayItem(
                              cost: 100,
                              onPressed: () {
                                onPayPressed(100);
                              },
                            ),
                            PayItem(
                              cost: 200,
                              onPressed: () {
                                onPayPressed(200);
                              },
                            ),
                            PayItem(
                              cost: 500,
                              onPressed: () {
                                onPayPressed(500);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        PayText(
                          text: 'Or',
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.3,
                            right: size.width * 0.3,
                          ),
                          child: Container(
                            height: 50,
                            child: TextField(
                              cursorColor: Colors.black,
                              textAlign: TextAlign.center,
                              controller: controller,
                              decoration: InputDecoration(
                                hintText: 'Type the amount',
                                fillColor: Colors.grey[300],
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.only(
                                  bottom: 25,
                                  left: 20,
                                  right: 20,
                                ),
                              ),
                              style: kBody2TextStyle.copyWith(),
                              keyboardType: TextInputType.number,
                              onChanged: (text){
                                setState(() {
                                  this.cost = int.parse(text);
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
                PayButton(
                  cost: this.cost,
                  onPayPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PaymentScreen(
                            cost: this.cost,
                            user: widget.user,
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
              ],
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 10,
                ),
                child: Material(
                  color: Colors.grey,
                  shape: CircleBorder(),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 30,
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

  void onPayPressed(int cost) {
    print(cost);
    this.cost = cost;
    this.controller.text = cost.toString();
    setState(() {});
  }
}

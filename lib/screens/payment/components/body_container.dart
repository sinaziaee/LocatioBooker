import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/payment/components/pay_text.dart';
import 'package:loctio_booker/screens/payment/components/pay_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../static_methods.dart';
import 'pay_button.dart';

class BodyContainer extends StatefulWidget {
  final int cost;
  final User user;
  final int villaId;

  BodyContainer(this.cost,
      this.user,
      this.villaId,);

  @override
  _BodyContainerState createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  TextEditingController cardController,
      expireDateController,
      cvvController,
      nameController;

  final String url = '$mainUrl/api/villa/pay/';

  @override
  void initState() {
    super.initState();
    cardController = TextEditingController();
    expireDateController = TextEditingController();
    cvvController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cost);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          PayText(text: ' Card Number'),
          SizedBox(
            height: 10,
          ),
          PayTextField(
            controller: cardController,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PayText(text: ' Expiry Date'),
                    SizedBox(
                      height: 10,
                    ),
                    PayTextField(
                      controller: expireDateController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PayText(text: ' CVV'),
                    SizedBox(
                      height: 10,
                    ),
                    PayTextField(
                      controller: cvvController,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          PayText(text: ' Name'),
          SizedBox(
            height: 10,
          ),
          PayTextField(
            controller: nameController,
          ),
          SizedBox(
            height: 50,
          ),
          PayButton(
            cost: widget.cost,
            onPayPressed: (){},
          ),
        ],
      ),
    );
  }

  payCost() async {
    Map map = Map();
    map['cost'] = widget.cost;
    map['villa_id'] = widget.villaId;
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: convert.json.encode(map),
    );
    if (response.statusCode < 400) {
      print(response.body);
      StaticMethods.showSuccessDialog(context, 'Villa Reserved');
    } //
    else {
      print('-------- ******************');
      print(response.statusCode);
      print(response.body);
      print('-------- ******************');
      StaticMethods.showErrorDialog(context, 'Failed to Reserve Villa !');
    }
  }
}

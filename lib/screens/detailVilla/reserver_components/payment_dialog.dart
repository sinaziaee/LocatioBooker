import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/detailVilla/reserver_components/payment_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PaymentDialog extends StatefulWidget {
  final int cost;
  final User user;

  PaymentDialog({
    this.cost,
    this.user,
  });

  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  final String walletUrl = '$mainUrl/api/villa/wallet/';
  // final String walletUrl = '$mainUrl/api/villa/wallet/';
  final String creditCardUrl = '$mainUrl/api/villa/credit/';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'How do you want to pay ?',
        textAlign: TextAlign.center,
      ),
      content: Row(
        children: [
          PaymentItem(
            iconData: FontAwesomeIcons.wallet,
            method: 'Wallet',
            onPressed: () {
              onWalletPressed(widget.cost);
            },
          ),
          PaymentItem(
            iconData: FontAwesomeIcons.moneyBill,
            method: 'Credit Card',
            onPressed: () {
              onCreditCardPressed(widget.cost);
            },
          ),
        ],
      ),
    );
  }

  void onWalletPressed(int cost) async {
    http.Response response = await http.post(
      Uri.parse(walletUrl),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: widget.user.token,
      },
      body: convert.json.encode(
        {},
      ),
    );
    if(response.statusCode < 400){
      print(response.body);
    } //
    else {
      print(response.statusCode);
      print(response.body);
    }
  }

  void onCreditCardPressed(int cost) async {
    http.Response response = await http.post(
      Uri.parse(creditCardUrl),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: widget.user.token,
      },
      body: convert.json.encode(
        {},
      ),
    );
    if(response.statusCode < 400){
      print(response.body);
    } //
    else {
      print(response.statusCode);
      print(response.body);
    }
  }
}

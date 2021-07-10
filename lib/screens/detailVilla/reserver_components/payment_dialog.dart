import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/screens/detailVilla/reserver_components/payment_item.dart';

class PaymentDialog extends StatefulWidget {
  PaymentDialog();

  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
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
          ),
          PaymentItem(
            iconData: FontAwesomeIcons.moneyBill,
            method: 'Credit Card',
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';

class termsAggrements extends StatelessWidget {
  static String id = 'terms_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SweetHome Terms and Conditions" ,
          style: kHeaderTextStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: 25.0, right: 25.0, top: 25.0
        ),
        child: Text('Last updated: (3/20/2021) Please read these Terms and Conditions carefully before using the http://www.SweetHome.com website and the SweetHome mobile application operated by SweetHome. Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms.\n These Terms apply to all visitors, users and others who access or use the Service.By accessing or using the Service you agree to be bound by these Terms.\n If you disagree with any part of the terms then you may not access the Service.\n'
        '________________________________________\nPurchases\nIf you wish to purchase any product or service made available through the Service , you may be asked to supply certain information relevant to your Purchase including, without limitation, your …\nSubscriptions\nSome parts of the Service are billed on a subscription basis. You will be billed in advance on a recurring ...\nContent Our Service allows you to post, link, store, share and otherwise make available certain information, text, graphics, videos, or other Content. You are responsible for the …\nContact Us\nIf you have any questions about these Terms, please contact us.' ,
          style: kBodyTextStyle,
        ),
      ),

    );
  }
}

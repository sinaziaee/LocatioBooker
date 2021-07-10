import 'package:flutter/material.dart';
import 'package:loctio_booker/screens/detailVilla/components2/back_icon.dart';
import 'package:loctio_booker/screens/help/components/help_item.dart';

import '../../static_methods.dart';

class HelpScreen extends StatelessWidget {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.myAppBar(
        'Terms and Conditions',
        context,
        null,
        isVisible: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HelpItem(
                    imageAsset: 'assets/images/help/debit-card.png',
                    size: size,
                    buttonText: 'Payment tips',
                    text:
                        'Learn how to pay to your host and what tips are best to follow.',
                  ),
                  HelpItem(
                    imageAsset: 'assets/images/help/cooking.png',
                    size: size,
                    buttonText: 'Hosting experience',
                    text: 'Learn how to host an experience with your friends.',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HelpItem(
                    imageAsset: 'assets/images/help/villa.png',
                    size: size,
                    buttonText: 'Hosting stays',
                    text:
                        'Learn how to use SweetHome for making money by being a host.',
                  ),
                  HelpItem(
                    imageAsset: 'assets/images/help/travel.png',
                    size: size,
                    buttonText: 'Booking and traveling',
                    text: 'Learn how to book and rent a place for your travel.',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HelpItem(
                    imageAsset: 'assets/images/help/problem.png',
                    size: size,
                    buttonText: 'Report a problem',
                    text:
                        'Learn how to report your problems about you host or passenger.',
                  ),
                  HelpItem(
                    imageAsset: 'assets/images/help/social-media.png',
                    size: size,
                    buttonText: 'Connect with people',
                    text:
                        'Learn how to make connections and find your friends at SweetHome.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

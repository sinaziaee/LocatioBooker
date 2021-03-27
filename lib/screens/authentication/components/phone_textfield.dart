import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../constants.dart';
import '../login_screen.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController phoneController;
  final Color color;

  PhoneTextField({this.phoneController, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: LoginScreen.size.height * 0.06,
      margin: EdgeInsets.symmetric(
          horizontal: LoginScreen.size.width * 0.05,
          vertical: LoginScreen.size.height * 0.005),
      child: IntlPhoneField(
        controller: phoneController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            bottom: LoginScreen.size.height * 0.03,
            left: LoginScreen.size.width * 0.03,
            right: LoginScreen.size.width * 0.03,
          ),
          hintText: 'Phone Number',
          focusedBorder: kOutLineInputBorder.copyWith(
            borderSide: BorderSide(
              color: color ?? Colors.black,
              width: 1.5,
              style: BorderStyle.solid,
            ),
          ),
          border: kOutLineInputBorder.copyWith(
            borderSide: BorderSide(
              color: color ?? Colors.grey,
              width: 0.5,
              style: BorderStyle.solid,
            ),
          ),
        ),
        onChanged: (phone) {
          print(phone.completeNumber);
        },
      ),
    );
  }
}

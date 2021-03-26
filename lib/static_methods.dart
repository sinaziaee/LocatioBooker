import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

class StaticMethods {
  static Future<void> saveToPreferences(
      {String firstName,
      String lastName,
      String token,
      String email,
      String country,
      String password,
      String phone}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (firstName != null) {
      preferences.setString("firstName", firstName);
    }
    if (lastName != null) {
      preferences.setString("lastName", lastName);
    }
    if (token != null) {
      preferences.setString("token", token);
    }
    if (password != null) {
      preferences.setString("password", password);
    }
    if (email != null) {
      preferences.setString("email", email);
    }
    if (phone != null) {
      preferences.setString("phone", phone);
    }
    if (token != null) {
      preferences.setString("token", token);
    }
  }

  static Future<User> getPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String email = preferences.getString("email");
    String firstName = preferences.getString("firstName");
    String lastName = preferences.getString("lastName");
    String password = preferences.getString("password");
    String phone = preferences.getString("phone");
    String token = preferences.getString("token");
    String country = preferences.getString("country");

    User user = User(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        token: token,
        country: country,
        phone: phone);

    return user;
  }

  static void showSuccessDialog(BuildContext context, String message){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'Successful',
        btnOkText: 'OK',
        desc: message,
        btnOkOnPress: () {},
        btnOkIcon: Icons.check_circle,
        btnOkColor: Colors.green).show();
  }

  static void showErrorDialog(BuildContext context, String message){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        title: 'Error',
        btnOkText: 'OK',
        desc: message,
        btnOkOnPress: () {},
        btnOkIcon: Icons.close,
        btnOkColor: Colors.red).show();
  }

}

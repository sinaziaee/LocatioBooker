import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'models/user.dart';

class StaticMethods {
  static Future<void> saveToPreferences(
      User user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (user.firstName != null) {
      preferences.setString("firstName", user.firstName);
    }
    if (user.lastName != null) {
      preferences.setString("lastName", user.lastName);
    }
    if (user.country != null) {
      preferences.setString("country", user.country);
    }
    if (user.token != null) {
      preferences.setString("token", user.token);
    }
    if (user.password != null) {
      preferences.setString("password", user.password);
    }
    if (user.email != null) {
      preferences.setString("email", user.email);
    }
    if (user.phone != null) {
      preferences.setString("phone", user.phone);
    }
    if (user.token != null) {
      preferences.setString("token", user.token);
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

  static Future<http.Response> upload(String url, Map map, {String vcCode, String token}) async{
    if(token != null){
      return await http.post(
        Uri.parse(url),
        body: convert.jsonEncode(
            map
        ),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          HttpHeaders.authorizationHeader: token,
        },
      );
    }
    if(vcCode == null){
      return await http.post(
        Uri.parse(url),
        body: convert.jsonEncode(
            map
        ),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );
    }
    else{
      map['vc_code'] = vcCode;
      return await http.post(
        Uri.parse(url),
        body: convert.jsonEncode(
            map
        ),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );
    }
  }

  static void printError(e){
    print('myError: ${e.toString()}');
  }

}

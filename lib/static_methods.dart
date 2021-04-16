import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'models/user.dart';

class StaticMethods {
  static Future<void> saveToPreferences(User user) async {
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

  static void showSuccessDialog(BuildContext context, String message) {
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
            btnOkColor: Colors.green)
        .show();
  }

  static void showErrorDialog(BuildContext context, String message) {
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
            btnOkColor: Colors.red)
        .show();
  }

  static Future<http.Response> upload(String url, Map map,
      {String vcCode, String token}) async {
    if (token != null) {
      return await http.post(
        Uri.parse(url),
        body: convert.jsonEncode(map),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          HttpHeaders.authorizationHeader: token,
        },
      );
    }
    if (vcCode == null) {
      return await http.post(
        Uri.parse(url),
        body: convert.jsonEncode(map),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );
    } else {
      map['vc_code'] = vcCode;
      return await http.post(
        Uri.parse(url),
        body: convert.jsonEncode(map),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );
    }
  }

  static void printError(e) {
    print('myError: ${e.toString()}');
  }

  static AlertDialog myAlertDialog(
      Function selectFromCamera, Function selectFromGallery) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Select Image',
                  textDirection: TextDirection.rtl,
                  style: kHeaderTextStyle.copyWith(color: Colors.grey[800]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              selectFromCamera();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'From Camera‌',
                    textDirection: TextDirection.rtl,
                    style: kBodyTextStyle.copyWith(color: Colors.grey[700]),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.camera_alt,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              selectFromGallery();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'From Gallery',
                    textDirection: TextDirection.rtl,
                    style: kBodyTextStyle.copyWith(color: Colors.grey[700]),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.insert_photo,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static PreferredSize myAppBar(String text, BuildContext context) {
    return PreferredSize(
      child: Container(
        decoration: kCustomAppBarDecoration,
        child: SafeArea(
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Spacer(
                flex: 2,
              ),
              Container(
                decoration: kCustomAppBarDecoration,
                child: Center(
                  child: Text(
                    text,
                    style: kHeaderTextStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
      preferredSize: Size(
        double.infinity,
        60,
      ),
    );
  }
}

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loctio_booker/constants.dart';
import 'package:opencage_geocoder/opencage_geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'models/user.dart';
import 'components/select_image_item.dart';
import 'screens/home/home_screen.dart';
import 'screens/hosting/00_hosing_screen.dart';

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
    if (user.country != null) {
      preferences.setInt("user_id", user.userId);
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
    if (user.image != null) {
      preferences.setString("image", user.image);
    }
    if (user.bio != null) {
      preferences.setString("bio", user.bio);
    }
    if (user.gender != null) {
      preferences.setString("gender", user.gender);
    }
    if (user.birthday != null) {
      preferences.setString("birthday", user.gender);
    }
    if (user.nationalCode != null) {
      preferences.setString("nationalCode", user.nationalCode);
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
    String bio = preferences.getString("bio");
    int userId = preferences.getInt("user_id");
    String image = preferences.getString("image");
    String nationalCode = preferences.getString("nationalCode");
    String gender = preferences.getString("gender");
    String dob = preferences.getString("birthday");
    User user = User(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      token: token,
      country: country,
      phone: phone,
      nationalCode: nationalCode,
      image: image,
      gender: gender,
      bio: bio,
      birthday: dob,
      userId: userId,
    );

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
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
            borderRadius: BorderRadius.circular(10),
            child: SelectImageItem(
              text: 'From Camera',
              iconData: Icons.camera_alt,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              selectFromGallery();
            },
            child: SelectImageItem(
              text: 'From Gallery',
              iconData: Icons.insert_photo,
            ),
          ),
        ],
      ),
    );
  }

  static PreferredSize resultAppBar(
      BuildContext context, String resultText, Size size) {
    return PreferredSize(
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            top: 15,
            bottom: 15,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.chevron_left_outlined),
                iconSize: 25,
              ),
              Expanded(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      resultText,
                      style: kBody2TextStyle.copyWith(),
                    ),
                    trailing: Icon(
                      Icons.search,
                      size: 40,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
            ],
          ),
        ),
      ),
      preferredSize: Size(size.width, 100),
    );
  }

  static Future<Coordinates> getLocation(BuildContext context, String cityValue,
      String stateValue, String countryValue) async {
    var geocoder = new Geocoder("7efb20c96c1a4cd594654de3842cd476");
    var response;
    try {
      if (cityValue == null && stateValue == null) {
        response = await geocoder.geocode(countryValue);
      } else if (cityValue == null) {
          response = await geocoder.geocode(countryValue);
      } else {
        response = await geocoder.geocode(cityValue);
      }
    } catch (e) {
      StaticMethods.showErrorDialog(
          context, 'Couldn\'t find geolocation of your city');
      print('-------------------------');
      print(e);
      return null;
    }
    return response.results[0].geometry;
  }

  static Future<http.Response> changeFavoriteStatus(
      {int villaId, User user, bool status}) async {
    String changeFavoriteUrl = '$mainUrl/api/villa/like/';
    try {
      http.Response response = await http.post(
        Uri.parse(changeFavoriteUrl),
        headers: {
          HttpHeaders.authorizationHeader: user.token,
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: convert.json.encode(
          {
            'villa_id': villaId,
            'like': status.toString(),
          },
        ),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode < 400) {
        return response;
      } //
      else {
        return null;
      }
    } //
    catch (e) {
      print(e);
    }
    return null;
  }

  static AppBar chatAppbar(BuildContext context, String imageUrl, String name) {
    print('$mainUrl$imageUrl');
    return AppBar(
      backgroundColor: Colors.blueGrey,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.keyboard_arrow_left),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: (imageUrl == null || imageUrl.length == 0)
                ? AssetImage('assets/images/unknown_person.png')
                : NetworkImage('$mainUrl$imageUrl'),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(name ?? ''),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static PreferredSize myAppBar(String text, BuildContext context, User user,
      {bool isVisible}) {
    if (isVisible == null) {
      isVisible = true;
    }
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
                flex: 2,
              ),
              Visibility(
                visible: isVisible,
                child: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HostingScreen(user),
                    //   ),
                    //       (route) => false,
                    // );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      HomeScreen.id,
                      (route) => false,
                      arguments: {
                        'user': user,
                      },
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HostingScreen(user),
                      ),
                    );
                  },
                ),
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

  static String getMonthString(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "Sth wrong in month";
    }
  }

  static List<String> datePickerSplitter(String dateRange) {
    int startIndex = dateRange.indexOf('startDate');
    dateRange = dateRange.substring(startIndex);
    List<String> stringList = dateRange.split(',');
    List<String> start = stringList[0].split(': ');
    List<String> end = stringList[1].split(': ');
    String startDate = start[1].substring(0, 10);
    String endDate = end[1].substring(0, 10);
    return [startDate, endDate];
  }
}

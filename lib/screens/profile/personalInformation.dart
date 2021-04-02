
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/home/home_screen.dart';
import 'package:loctio_booker/screens/profile/settings.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../static_methods.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


// ignore: camel_case_types
class personalInformation extends StatefulWidget {
  static String id = 'personal_page';

  @override
  _personalInformationState createState() => _personalInformationState();
}

// ignore: camel_case_types
class _personalInformationState extends State<personalInformation> {
  bool showSpinner = false;
  User user;
  String firstName = "",
      lastName = "",
      email,
      phoneNumber,
      country;

  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController phoneController;


  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  String url = "$mainUrl/api/account/properties/update";

  Future<User> _getPreferences() async {
    user = await StaticMethods.getPreferences();
    firstName = user.firstName;
    lastName = user.lastName;
    email = user.email;
    phoneNumber = user.phone;
    country = user.country;

    print("user.firstName : " + firstName);

    return user;
  }

  @override
  void initState() {
    _getPreferences();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
          progressIndicator: kMyProgressIndicator,
          inAsyncCall: showSpinner,
          child: FutureBuilder(
            future: _getPreferences(),

            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.white,
                  child: new ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          new Container(
                            height: 250.0,
                            color: Colors.white,
                            child: new Column(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0, top: 20.0),
                                    child: new Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.arrow_back_ios),
                                          color: Colors.black,
                                          onPressed: () {
                                            Navigator.popAndPushNamed(
                                                context, Settings.id);
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 25.0),
                                          child: new Text('my Profile',
                                              style: kHeaderTextStyle,
                                          ),
                                        )
                                      ],
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: new Stack(
                                      fit: StackFit.loose, children: <Widget>[
                                    new Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Container(
                                            width: 140.0,
                                            height: 140.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                image: new ExactAssetImage(
                                                    'assets/images/as.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 90.0, right: 100.0),
                                        child: new Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            new CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 25.0,
                                              child: new Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )),
                                  ]),
                                )
                              ],
                            ),
                          ),
                          new Container(
                            color: Color(0xffFFFFFF),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 25.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                           Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                               Text(
                                                'Parsonal Information',
                                                style: kBodyTextStyle
                                              ),
                                            ],
                                          ),
                                          new Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              _status
                                                  ? _getEditIcon()
                                                  : new Container(),
                                            ],
                                          )
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          new Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              new Text(
                                                'First Name',
                                                style: kBodyTextStyle,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                           Flexible(
                                            child:  TextField(
                                              decoration: InputDecoration(
                                                hintText: firstName ,
                                              ),
                                              enabled: !_status,
                                              autofocus: !_status,
                                              controller: firstNameController,

                                            ),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          new Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              new Text(
                                                'Last Name',
                                                style: kBodyTextStyle,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                           Flexible(
                                            child:  TextField(
                                              decoration:  InputDecoration(
                                                  hintText: lastName),
                                              enabled: !_status,
                                              controller: lastNameController,
                                            ),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          new Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              new Text(
                                                'Mobile Number',
                                                style: kBodyTextStyle,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                           Flexible(
                                            child: TextField(
                                              decoration:  InputDecoration(
                                                  hintText: phoneNumber),
                                              enabled: !_status,
                                            ),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          new Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              new Text(
                                                'Bio-Graphy',
                                                style: kBodyTextStyle,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0
                                      ),
                                    child:  Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Flexible(
                                          child:  TextField(
                                            decoration:  InputDecoration(
                                                hintText: phoneNumber),
                                            enabled: !_status,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          new Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                               Text(
                                                'E-mail',
                                                style: kBodyTextStyle,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0
                                    ),
                                    child:  Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Flexible(
                                          child:  TextField(
                                            decoration:  InputDecoration(
                                                hintText: email),
                                            enabled: !_status,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                'Gender ',
                                                style: kBodyTextStyle,
                                              ),
                                            ),
                                            flex: 2,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                'Date Of Birth',
                                                style: kBodyTextStyle,
                                              ),
                                            ),
                                            flex: 2,
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 10.0),
                                              child: new TextField(
                                                decoration: const InputDecoration(
                                                    hintText: "Enter Pin Code"),
                                                enabled: !_status,
                                              ),
                                            ),
                                            flex: 2,
                                          ),
                                          Flexible(
                                            child: new TextField(
                                              decoration: const InputDecoration(
                                                  hintText: "Enter State"),
                                              enabled: !_status,
                                            ),
                                            flex: 2,
                                          ),
                                        ],
                                      )),
                                  !_status
                                      ? _getActionButtons()
                                      : new Container(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        )
    );
  }


  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                        isValidated();
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

bool isValidated() {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;

    if (firstName.length < 3) {
      StaticMethods.showErrorDialog(context, 'Bad First Name Format');
      return false;
    } else if (lastName.length < 3) {
      StaticMethods.showErrorDialog(context, 'Bad Last Name Format');
      return false;
    } else if (phone.length < 3) {
      StaticMethods.showErrorDialog(context, 'Bad Phone Format');
      return false;
    }

    user = User(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      country: country ?? 'US',
    );
    return true;
  }


  uploadInfo() async {
    try {
      http.Response response = await StaticMethods.upload(
        url,
        user.toJson(),
      );
      showSpinner = false;
      setState(() {});
      print('statusCode: ${response.statusCode}');
      if (response.statusCode < 400) {
        var jsonResponse =
        convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        print(jsonResponse);
        user = User.fromJson(jsonResponse);
        saveInfo();
      } else {
        StaticMethods.showErrorDialog(
            context, 'An Error happened while signing up');
        print(response.body);
      }
    } catch (e) {
      showSpinner = false;
      setState(() {});
      StaticMethods.printError(e.toString());
    }
  }

  saveInfo() async {
    await StaticMethods.saveToPreferences(user);
    Navigator.pushNamedAndRemoveUntil(
      context,
      HomeScreen.id,
          (route) => false,
      arguments: {
        'user': user,
      },
    );
  }






}




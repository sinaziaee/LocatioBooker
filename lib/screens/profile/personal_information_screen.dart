import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/home/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'components/profile_header_title.dart';
import 'components/custom_avatar.dart';
import 'components/personal_info_edit_state.dart';
import 'components/title_component.dart';
import 'components/textfield_component.dart';
import 'components/action_button.dart';
import '../../static_methods.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PersonalInformationScreen extends StatefulWidget {
  static String id = 'personal_page';

  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

// ignore: camel_case_types
class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  bool showSpinner = false;
  User user;
  String firstName = "", lastName = "", email, phoneNumber, country;
  String token;
  TextEditingController firstNameController,
      lastNameController,
      phoneController,
      genderController,
      bioController,
      birthController,
      emailController;

  String selectedGender;

  bool status = true;
  final FocusNode myFocusNode = FocusNode();

  String url = "$mainUrl/api/account/properties/update";

  Future<User> _getPreferences() async {
    user = await StaticMethods.getPreferences();
    firstName = user.firstName;
    lastName = user.lastName;
    email = user.email;
    phoneNumber = user.phone;
    country = user.country;
    token = user.token;
    print(user.gender);
    if (user.gender == null) {
      print('here1');
      selectedGender = allGenders[0];
    } else if (user.gender == 'male') {
      print('here2');
      selectedGender = allGenders[0];
    } else {
      selectedGender = allGenders[1];
    }

    firstNameController.text = firstName;
    lastNameController.text = lastName;
    phoneController.text = phoneNumber;

    return user;
  }

  List allGenders = [
    'Male',
    'Female',
  ];

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    bioController = TextEditingController();
    birthController = TextEditingController();
    genderController = TextEditingController();

    _getPreferences();

    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    birthController.dispose();
    genderController.dispose();
    bioController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      progressIndicator: kMyProgressIndicator,
      inAsyncCall: showSpinner,
      child: SafeArea(
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
                              ProfileHeader(),
                              CustomAvatar(),
                            ],
                          ),
                        ),
                        new Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                PersonalInfoEditStateComponent(
                                  onTapped: () {
                                    onEditTapped();
                                  },
                                  status: status,
                                ),
                                TitleComponent(
                                  'First Name',
                                ),
                                TextFieldComponent(
                                  status: status,
                                  controller: firstNameController,
                                  hintText: 'First Name',
                                ),
                                TitleComponent(
                                  'Last Name',
                                ),
                                TextFieldComponent(
                                  status: status,
                                  controller: lastNameController,
                                  hintText: 'Last Name',
                                ),
                                TitleComponent(
                                  'Phone Name',
                                ),
                                TextFieldComponent(
                                  status: status,
                                  controller: phoneController,
                                  hintText: 'Phone Number',
                                ),
                                TitleComponent(
                                  'Bio-Graphy',
                                ),
                                TextFieldComponent(
                                  status: status,
                                  controller: bioController,
                                  hintText: 'Bio-Graphy',
                                ),
                                TitleComponent(
                                  'Email',
                                ),
                                TextFieldComponent(
                                  status: status,
                                  controller: emailController,
                                  hintText: 'Email',
                                  isReadOnly: true,
                                ),
                                // Padding(
                                //     padding: EdgeInsets.only(
                                //         left: 25.0, right: 25.0, top: 25.0),
                                //     child: new Row(
                                //       mainAxisSize: MainAxisSize.max,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.start,
                                //       children: <Widget>[
                                //         Expanded(
                                //           child: Container(
                                //             child: Text(
                                //               'Gender ',
                                //               style: kBodyTextStyle,
                                //             ),
                                //           ),
                                //           flex: 2,
                                //         ),
                                //         Expanded(
                                //           child: Container(
                                //             child: Text(
                                //               'Date Of Birth',
                                //               style: kBodyTextStyle,
                                //             ),
                                //           ),
                                //           flex: 2,
                                //         ),
                                //       ],
                                //     )),
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //       left: 25.0, right: 25.0, top: 2.0),
                                //   child: new Row(
                                //     mainAxisSize: MainAxisSize.max,
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: <Widget>[
                                //       Expanded(
                                //         child: Material(
                                //           child: InkWell(
                                //             onTap: () {
                                //               showSelectGenderDialog();
                                //             },
                                //             child: Container(
                                //               child: Text(
                                //                 (selectedGender == null)
                                //                     ? 'Tap to select gender'
                                //                     : selectedGender,
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //       Expanded(
                                //         child: new TextField(
                                //           onTap: () {
                                //             showDateDialog();
                                //           },
                                //           readOnly: true,
                                //           decoration: const InputDecoration(
                                //               hintText: "Enter Birth Date"),
                                //           enabled: !status,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                !status
                                    ? ActionButton(
                                        onCancelPressed: () {
                                          onCancelPressed();
                                        },
                                        onSavedPressed: () {
                                          onSavedPressed();
                                        },
                                      )
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
      ),
    ));
  }

  onSavedPressed() {
    setState(
      () {
        status = true;
        FocusScope.of(context).requestFocus(new FocusNode());
        if (isValidated()) uploadInfo();
      },
    );
  }

  onCancelPressed() {
    setState(
      () {
        status = true;
        FocusScope.of(context).requestFocus(new FocusNode());
      },
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
    } else if (phoneNumber.length < 3) {
      StaticMethods.showErrorDialog(context, 'Bad phone Number Format');
      return false;
    }

    user = User(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      country: country ?? 'US',
      gender: selectedGender,
    );
    //uploadInfo();
    return true;
  }

  uploadInfo() async {
    setState(() {
      showSpinner = true;
    });
    try {
      http.Response response = await StaticMethods.upload(
        url,
        user.toJson(),
        token: token,
      );
      showSpinner = false;
      setState(() {});
      print('statusCode: ${response.statusCode}');
      print('response.body : ' + response.body.toString());
      if (response.statusCode < 400) {
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        print(jsonResponse);
        user = User.fromJson(jsonResponse);
        saveInfo();
      } else {
        StaticMethods.showErrorDialog(
            context, 'An Error happened updating profile');
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

  onEditTapped() {
    status = false;
    setState(() {});
  }

  showDateDialog() async {
    final DateTime selectedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 01, 01),
      firstDate: DateTime(1900, 01, 01),
      lastDate: DateTime(2020, 01, 01),
    );

    print(selectedDateTime);
  }

  showSelectGenderDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Select Gender'),
          content: Container(
            height: 100,
            width: 100,
            child: Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Material(
                      child: Container(
                        child: InkWell(
                          onTap:(){
                            selectedGender = allGenders[index];
                            setState(() {

                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: Center(child: Text(allGenders[index], style: kBodyTextStyle,)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: allGenders.length,
              ),
            ),
          ),
        );
      },
    );
  }
}

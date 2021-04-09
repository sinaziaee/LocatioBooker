import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
  String firstName = "", lastName = "", email, phoneNumber, country;

  TextEditingController firstNameController,
      lastNameController,
      phoneController,
      genderController,
      bioController,
      birthController,
      emailController;

  bool status = true;
  final FocusNode myFocusNode = FocusNode();
  File imageFile;
  String base64Image;

  String url = "$mainUrl/api/account/properties/update";

  Future<void> _pickImage(ImageSource source) async {
    try {
      final _picker = ImagePicker();
      PickedFile image = await _picker.getImage(source: source);

      final File selected = File(image.path);

      setState(() {
        imageFile = selected;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _cropImage() async {
    try {
      File cropped = await ImageCropper.cropImage(
        cropStyle: CropStyle.circle,
        sourcePath: imageFile.path,
      );

      setState(() {
        imageFile = cropped ?? imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  void _clear() {
    setState(() {
      imageFile = null;
    });
  }

  selectFromGallery() {
    _pickImage(ImageSource.gallery);
    Navigator.pop(context);
  }

  selectFromCamera() {
    _pickImage(ImageSource.camera);
    Navigator.pop(context);
  }

  Future<User> _getPreferences() async {
    user = await StaticMethods.getPreferences();
    firstName = user.firstName;
    lastName = user.lastName;
    email = user.email;
    phoneNumber = user.phone;
    country = user.country;

    firstNameController.text = firstName;
    lastNameController.text = lastName;
    phoneController.text = phoneNumber;
    emailController.text = user.email;

    return user;
  }

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
                              CustomAvatar(
                                () {
                                  onImageSelectPressed();
                                },
                              ),
                              if (imageFile != null) ...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: _cropImage,
                                      child: Icon(Icons.crop),
                                    ),
                                    TextButton(
                                      onPressed: _clear,
                                      child: Icon(Icons.refresh),
                                    ),
                                  ],
                                ),
                              ] else ...[
                                SizedBox(),
                              ],
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
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: TextFieldComponent(
                                          status: status,
                                          controller: genderController,
                                          hintText: 'gender',
                                        ),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: new TextField(
                                          onTap: () {
                                            showDateDialog();
                                          },
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Birth Date"),
                                          enabled: !status,
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  ),
                                ),
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
    String bio = bioController.text;

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
    // else if (bio.length < 3) {
    //   StaticMethods.showErrorDialog(context, 'Bad Bio Format');
    //   return false;
    // }
    user = User(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      country: country ?? 'US',
    );
    //uploadInfo();
    return true;
  }

  uploadInfo() async {
    setState(() {
      showSpinner = true;
    });
    print(user.token);
    try {
      http.Response response = await StaticMethods.upload(
        url,
        user.toJson(),
        token: user.token,
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

  void onImageSelectPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StaticMethods.myAlertDialog(selectFromCamera, selectFromGallery);
      },
    );
  }
}

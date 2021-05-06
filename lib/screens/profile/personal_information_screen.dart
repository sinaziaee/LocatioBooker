import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'components/gender_alert.dart';


class PersonalInformation extends StatefulWidget {
  static String id = 'personal_page';

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

// ignore: camel_case_types
class _PersonalInformationState extends State<PersonalInformation> {
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

  bool status = true;
  final FocusNode myFocusNode = FocusNode();
  File imageFile;
  String getImageUrl = '$mainUrl/api/account/show_account_image';
  String uploadImageUrl = '$mainUrl/api/account/update_account_image';
  String url = "$mainUrl/api/account/properties/update";
  String gender = '';

  // String updateProfileUrl = "$mainUrl/api/account/properties/update";

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
    // print('TOOOOOOOken: ${user.token}');
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    phoneController.text = phoneNumber;
    emailController.text = user.email;
    bioController.text = user.bio;
    genderController.text = user.gender;
    token = user.token;
    // print(token);
    try {
      // user.printUser();
    } catch (e) {
      print(e);
    }
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
    // print('token is: ${user.token}');
    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: kMyProgressIndicator,
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                ProfileHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 250.0,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              FutureBuilder(
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.connectionState ==
                                          ConnectionState.done) {
                                    User user = snapshot.data;
                                    return CustomAvatar(
                                      onImageSelectPressed: () {
                                        onImageSelectPressed();
                                      },
                                      imageFile: imageFile,
                                      imageUrl: '$mainUrl${user.image}',
                                    );
                                  } else {
                                    return CustomAvatar(
                                      onImageSelectPressed: () {
                                        onImageSelectPressed();
                                      },
                                      imageFile: imageFile,
                                      imageUrl: '',
                                    );
                                  }
                                },
                                future: _getPreferences(),
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
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.0),
                            child: Column(
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
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                                      Expanded(
                                        child: Material(
                                          child: InkWell(
                                            child: Container(
                                              height: 50,
                                              width: 150,
                                              child: Center(
                                                child: Text(
                                                  (gender != null &&
                                                      gender.length != 0)
                                                      ? gender
                                                      : 'N/A',
                                                  style: kBody2TextStyle.copyWith(),
                                                ),
                                              ),
                                              margin: EdgeInsets.only(
                                                right: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.grey[400],
                                                    width: 1.5,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              if(!status == true){
                                                onGenderDialogPressed();
                                              }
                                            },
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: new TextField(
                                          onTap: () {
                                            showDateDialog();
                                          },
                                          controller: birthController,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
    // String bio = bioController.text;

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
      bio: bio,
      token: token,
      gender: gender,
      // country: country ?? 'US',
    );
    //uploadInfo();
    return true;
  }

  uploadInfo() async {
    setState(() {
      showSpinner = true;
    });
    // print('Token: ');
    // print(user.token);

    Map map = Map();
    Map userMap = user.toJson();
    for (String key in userMap.keys) {
      map[key] = userMap[key];
    }
    if (imageFile != null) {
      // print(imageFile.path);
      String base64file = convert.base64Encode(imageFile.readAsBytesSync());
      map['filename'] = imageFile.path.split('/').last;
      // map['base64'] = base64file;
      map['image'] = base64file;
    }

    // print('******************************************************');
    // print('beforeUpload token: $token');

    try {
      // bool result = await uploadImage();
      // if(result == false){
      //   return;
      // }
      http.Response response = await StaticMethods.upload(
        url,
        map,
        token: token,
      );
      showSpinner = false;
      setState(() {});
      // print('statusCode: ${response.statusCode}');
      // print('response.body : ' + response.body.toString());
      if (response.statusCode < 400) {
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        // print(jsonResponse);
        user = User.fromJson(jsonResponse);
        user.token = token;

        // user.image = await getImage();
        saveInfo();
      } else {
        StaticMethods.showErrorDialog(
            context, 'An Error happened updating profile');
        // print(response.body);
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
    birthController.text = selectedDateTime.toString().substring(0, 10);
    // print(selectedDateTime);
  }

  void onImageSelectPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StaticMethods.myAlertDialog(selectFromCamera, selectFromGallery);
      },
    );
  }

  void onGenderDialogPressed() {
    print('==================');
    showDialog(
      context: context,
      builder: (context) {
        return GenderAlertDialog(
          gender: gender,
          femalePressed: () {
            setState(() {
              gender = 'Female';
            });
            Navigator.pop(context);
          },
          malePressed: () {
            setState(() {
              gender = 'Male';
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

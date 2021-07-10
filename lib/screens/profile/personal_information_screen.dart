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
import '../../components/select_image_item.dart';
import '../payment/pay_amounts_screen.dart';

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
      bioController,
      genderController,
      dobController,
      emailController;

  bool status = true;
  File imageFile;
  String getImageUrl = '$mainUrl/api/account/show_account_image';
  String uploadImageUrl = '$mainUrl/api/account/update_account_image';
  String url = "$mainUrl/api/account/properties/update";
  int balance;

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
    print(user.bio);
    bioController.text = user.bio;
    token = user.token;
    // dobController.text = user.birthday;
    return user;
  }

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    bioController = TextEditingController();
    genderController = TextEditingController();
    dobController = TextEditingController();
    // _getPreferences();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    bioController.dispose();
    genderController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('---------gender: ${genderController.text} -------');
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
                          height: 210.0,
                          color: Colors.white,
                          child: Stack(
                            children: [
                              Column(
                                children: <Widget>[
                                  FutureBuilder(
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.connectionState ==
                                              ConnectionState.done) {
                                        User user = snapshot.data;
                                        return CustomAvatar(
                                          onImageSelectPressed: () {
                                            if (status == true) {
                                              return;
                                            }
                                            onImageSelectPressed();
                                          },
                                          imageFile: imageFile,
                                          status: status,
                                          imageUrl: '$mainUrl${user.image}',
                                        );
                                      } //
                                      else {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              Positioned(
                                top: 50,
                                right: 20,
                                child: Material(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return PayAmountScreen(user);
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 90,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.wallet,
                                            color: Colors.blueGrey,
                                            size: 40,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('${balance ?? 'N/A'} \$'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            right: 5,
                                          ),
                                          child: TextField(
                                            onTap: () {
                                              onGenderDialogPressed();
                                            },
                                            textAlign: TextAlign.center,
                                            controller: genderController,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                                hintText: "Gender"),
                                            // enabled: !status,
                                            enabled: false,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: TextField(
                                            onTap: () {
                                              showDateDialog();
                                            },
                                            textAlign: TextAlign.center,
                                            controller: dobController,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                                hintText: "Enter Birth Date"),
                                            // enabled: !status,
                                            enabled: false,
                                          ),
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
        if (isValidated()) uploadInfo();
      },
    );
  }

  onCancelPressed() {
    setState(
      () {
        status = true;
      },
    );
  }

  bool isValidated() {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String bio = bioController.text;
    String gender = genderController.text;
    String dob = dobController.text;

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
      birthday: dob,
    );
    return true;
  }

  uploadInfo() async {
    setState(() {
      showSpinner = true;
    });

    Map map = Map();
    Map userMap = user.toJson();
    // print(user.gender);
    // print(user.dob);
    for (String key in userMap.keys) {
      map[key] = userMap[key];
    }
    if (imageFile != null) {
      String base64file = convert.base64Encode(imageFile.readAsBytesSync());
      map['filename'] = imageFile.path.split('/').last;
      map['image'] = base64file;
    }

    try {
      http.Response response = await StaticMethods.upload(
        url,
        map,
        token: token,
      );
      showSpinner = false;
      setState(() {});
      if (response.statusCode < 400) {
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        print(jsonResponse);
        user = User.fromJson(jsonResponse);
        user.token = token;
        saveInfo();
      } else {
        StaticMethods.showErrorDialog(
            context, 'An Error happened updating profile');
        print(response.statusCode);
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
    dobController.text = selectedDateTime.toString().substring(0, 10);
  }

  void onImageSelectPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
      },
    );
  }

  void onGenderDialogPressed() {
    showDialog(
      context: context,
      builder: (context) {
        return GenderAlertDialog(
          gender: genderController.text,
          femalePressed: () {
            setState(() {
              genderController.text = 'Female';
            });
            Navigator.pop(context);
          },
          malePressed: () {
            setState(() {
              genderController.text = 'Male';
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

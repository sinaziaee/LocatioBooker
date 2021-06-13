import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loctio_booker/models/facilitation.dart';
import 'package:loctio_booker/models/laws.dart';
import 'package:loctio_booker/models/place_address.dart';
import 'package:loctio_booker/models/resort_description.dart';
import 'package:loctio_booker/models/resort_identification.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/home/home_screen.dart';
import 'package:loctio_booker/screens/hosting/components/image_container.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../constants.dart';
import '../../static_methods.dart';
import '00_hosing_screen.dart';
import 'components/bottom_container.dart';
import "package:latlong2/latlong.dart" as latLng;


class IdentityScreen extends StatefulWidget {
  final String villa;
  final ResortDescription resortDescription;
  final ResortIdentification resortIdentification;
  final Facilitation facilitation;
  final PlaceAddress placeAddress;
  final User user;
  final List imageIds;
  final Key key = Key('resort_identity_screen_key');
  final bool haveUploadedUserIdentity;
  final latLng.LatLng location;
  final Laws laws;

  IdentityScreen({
    this.villa,
    @required this.user,
    this.resortDescription,
    this.resortIdentification,
    this.facilitation,
    this.placeAddress,
    this.imageIds,
    @required this.haveUploadedUserIdentity,
    this.laws,
    this.location,
  });

  @override
  _IdentityScreenState createState() => _IdentityScreenState();
}

class _IdentityScreenState extends State<IdentityScreen> {
  File file, imageFile;
  bool showSpinner = false;
  Size size;
  List<int> fileList = [];
  String villaUrl = '$mainUrl/api/villa/user/documents/';
  String identityUrl = '$mainUrl/api/account/upload-documents';
  String url = '$mainUrl/api/villa/user/';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    print(widget.imageIds);
    return Scaffold(
      appBar: StaticMethods.myAppBar('Identity Screen', context, widget.user),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: kMyProgressIndicator,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (file != null) ...[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                      'Upload place documents such as a owner document or electric bills.'),
                ),
                Center(
                  child: IconButton(
                    iconSize: 60,
                    icon: Icon(Icons.attach_file_sharp),
                    onPressed: () {
                      setState(() {
                        file = null;
                      });
                    },
                  ),
                ),
                Center(
                  child: Text(
                    'selected file: (${file.path.split('/').last})',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ] else ...[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                      'Upload place documents such as a owner document or electric bills.'),
                ),
                ImageContainer(
                  onImageSelectPressed: () {
                    onPlaceImageSelectPressed();
                  },
                  headerText: 'Upload an electric bill, ...',
                  bodyText: '',
                  size: size,
                  width: size.width * 0.8,
                  height: size.height * 0.25,
                  iconData: Icons.cloud_upload,
                ),
              ],
              if (widget.haveUploadedUserIdentity == null ||
                  widget.haveUploadedUserIdentity == false) ...[
                if (imageFile != null) ...[
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                        'Upload your identification docs such as National card.'),
                  ),
                  Center(
                    child: IconButton(
                      iconSize: 60,
                      icon: Icon(Icons.attach_file_sharp),
                      onPressed: () {
                        setState(() {
                          imageFile = null;
                        });
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      'selected file: (${imageFile.path.split('/').last})',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ] else ...[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                        'Upload identity documents such as a national card.'),
                  ),
                  ImageContainer(
                    onImageSelectPressed: () {
                      onIdentityImageSelectPressed();
                    },
                    headerText: 'Upload a national card',
                    bodyText: '',
                    size: size,
                    width: size.width * 0.8,
                    height: size.height * 0.25,
                  ),
                ],
              ] else ...[
                // pass
              ],
              customContainer(),
            ],
          ),
        ),
      ),
    );
  }

  customContainer() {
    return BottomContainer(
      key: Key('submit_identity'),
      text: 'Submit & Continue',
      onPressed: () {
        onPressed();
      },
    );
  }

  onPressed() async {
    if (file == null) {
      StaticMethods.showErrorDialog(
          context, 'Select an image for the villa first');
      return;
    }
    setState(() {
      showSpinner = true;
    });
    await uploadVillaDocumentFile();
    // if (imageFile != null) {
    //   await uploadUserDocumentFile();
    // }
    // uploadAll();

    // Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   HostingScreen.id,
    //       (route) => false,
    //
    //   arguments: {
    //     'user': widget.user,
    //   },
    // );
  }


  uploadVillaDocumentFile() async {
    print('-------------------------');
    print(villaUrl);
    print(file.path);
    Dio dio = new Dio();
    // dio.post(uploadUrl, data: )
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
    }); // just like JS
    // formdata.add("photos", new MultipartFile(file, basename(file.path)));
    dio
        .post(
      villaUrl,
      data: formData,
      options: Options(
          method: 'POST',
          headers: {
            HttpHeaders.authorizationHeader: widget.user.token,
            // HttpHeaders.authorizationHeader: 'Token bab330f8321c61a9ba457fab4efc1b223c3f8731',
          },
          responseType: ResponseType.json // or ResponseType.JSON
          ),
    )
        .then((response) {
      print('=========================================');
      print(response);
      print('=========================================');
      print(response.data);
      // var jsonRes = convert.json.decode(response);
      // print(jsonRes);
      // for(var each in jsonRes){
      //   print(each);
      //   fileList.add(each['document_id']);
      // }
      fileList.add(response.data['document_id']);
      if (imageFile != null) {
        uploadUserDocumentFile();
      }
      else{
        uploadAll();
      }
    }).catchError((error) {
      print(error);
      setState(() {
        showSpinner = false;
      });
    });
  }

  uploadUserDocumentFile() async {
    print('-------------------------');
    print(identityUrl);
    print(imageFile.path);
    Dio dio = new Dio();
    // dio.post(uploadUrl, data: )
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
    }); // just like JS
    // formdata.add("photos", new MultipartFile(file, basename(file.path)));
    dio
        .post(
      identityUrl,
      data: formData,
      options: Options(
          method: 'POST',
          headers: {
            HttpHeaders.authorizationHeader: widget.user.token,
            // HttpHeaders.authorizationHeader: 'Token bab330f8321c61a9ba457fab4efc1b223c3f8731',
          },
          responseType: ResponseType.json // or ResponseType.JSON
          ),
    )
        .then((response) {
      uploadAll();
      print(response);
    }).catchError((error) {
      print(error);
      setState(() {
        showSpinner = false;
      });
    });
  }

  selectFromGallery() {
    pickImage(ImageSource.gallery);
    Navigator.pop(context);
  }

  selectFromCamera() {
    pickImage(ImageSource.camera);
    Navigator.pop(context);
  }

  onIdentityImageSelectPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StaticMethods.myAlertDialog(selectFromCamera, selectFromGallery);
      },
    );
    setState(() {});
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final _picker = ImagePicker();
      PickedFile image = await _picker.getImage(source: source);

      final File selected = File(image.path);
      imageFile = selected;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  onPlaceImageSelectPressed() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path);
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  uploadAll() async {
    print('------------------------------------------------');
    print(widget.facilitation.getItemsList());
    print('------------------------------------------------');

    Map map = Map();
    map['type'] = widget.villa;
    // map['type'] = 'Coastal';
    map['country'] = widget.placeAddress.country;
    map['state'] = widget.placeAddress.state;
    map['city'] = widget.placeAddress.city;
    map['postal_code'] = widget.placeAddress.postalCode.toString();
    map['name'] = widget.resortDescription.name;
    // todo: check about
    map['description'] = widget.resortDescription.about;
    map['area'] = widget.resortDescription.area;
    map['price_per_night'] = widget.resortDescription.price;
    map['address'] = widget.placeAddress.address;
    map['latitude'] = widget.location.latitude.toString();
    map['longitude'] = widget.location.longitude.toString();
    map['capacity'] = widget.resortIdentification.bCapacity;
    map['max_capacity'] = widget.resortIdentification.mCapacity;
    map['number_of_bathrooms'] = widget.resortIdentification.numBathrooms;
    print(widget.resortIdentification.numShowers);
    map['number_of_showers'] = widget.resortIdentification.numShowers;
    map['number_of_single_beds'] = widget.resortIdentification.numSingleBeds;
    map['number_of_double_beds'] = widget.resortIdentification.numDoubleBeds;
    map['number_of_bedrooms'] = widget.resortIdentification.numRooms;
    map['image_id_list'] = widget.imageIds;
    map['facilities_list'] = widget.facilitation.getItemsList();
    map["doc_id_list"] = fileList;
    // todo: upload laws too
    map['rules_id_list'] = widget.laws.lawsList;
    try {
      print(url);
      http.Response response = await http.post(
        Uri.parse(url),
        body: convert.jsonEncode(map),
        headers: {
          HttpHeaders.authorizationHeader: widget.user.token,
          // HttpHeaders.authorizationHeader: 'Token bab330f8321c61a9ba457fab4efc1b223c3f8731',
          "Accept": "application/json",
          "content-type": "application/json",
        },
      );
      if (response.statusCode < 400) {
        print(response.statusCode);
        setState(() {
          showSpinner = false;
        });
        AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: false,
            title: 'Successful',
            btnOkText: 'OK',
            desc: 'Your place is saved successfully',
            btnOkOnPress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.id,
                    (route) => false,
                arguments: {
                  'user': widget.user,
                },
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HostingScreen(widget.user),
                ),
              );
            },
            btnOkIcon: Icons.check_circle,
            btnOkColor: Colors.green)
            .show();
      } else {
        print(response.statusCode);
        print(response.body);
        setState(() {
          showSpinner = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        showSpinner = false;
      });
    }
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loctio_booker/models/facilitation.dart';
import 'package:loctio_booker/models/place_address.dart';
import 'package:loctio_booker/models/resort_description.dart';
import 'package:loctio_booker/models/resort_identification.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/hosting/components/image_container.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../constants.dart';
import '../../static_methods.dart';
import 'components/bottom_container.dart';

class IdentityScreen extends StatefulWidget {
  final String villa;
  final ResortDescription resortDescription;
  final ResortIdentification resortIdentification;
  final Facilitation facilitation;
  final PlaceAddress placeAddress;
  final User user;
  final List imageIds;
  final bool haveUploadedUserIdentity;

  IdentityScreen({
    this.villa,
    @required this.user,
    this.resortDescription,
    this.resortIdentification,
    this.facilitation,
    this.placeAddress,
    this.imageIds,
    @required this.haveUploadedUserIdentity,
  });

  @override
  _IdentityScreenState createState() => _IdentityScreenState();
}

class _IdentityScreenState extends State<IdentityScreen> {
  File file, imageFile;
  String uploadUrl = '';
  String uploadImageUrl = '';
  String url = '';
  bool showSpinner = false;
  Size size;
  List<File> fileList = [];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    print(widget.imageIds);
    return Scaffold(
      appBar: StaticMethods.myAppBar('Identity Screen', context),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: kMyProgressIndicator,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text('Upload your place document or Electric bill'),
              ),
              ImageContainer(
                onImageSelectPressed: () {
                  onPlaceImageSelectPressed();
                },
                headerText: 'Upload Place document',
                bodyText: '',
                size: size,
                width: size.width * 0.8,
                height: size.height * 0.25,
                iconData: Icons.cloud_upload,
              ),
              if (widget.haveUploadedUserIdentity == null ||
                  widget.haveUploadedUserIdentity == false) ...[
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
      text: 'Submit & Continue',
      onPressed: () {
        onPressed();
      },
    );
  }

  onPressed() {
    uploadFile(file, uploadUrl);
    uploadFile(imageFile, uploadImageUrl);

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

  // uploadImage(File file) async {
  //   setState(() {
  //     showSpinner = true;
  //   });
  //   widget.user.printUser();
  //   print('in uploading images');
  //   Map map = Map();
  //   if (file != null) {
  //     String base64file = convert.base64Encode(file.readAsBytesSync());
  //     map['filename'] = file.path.split('/').last;
  //     map['image_file'] = base64file;
  //   }
  //   try {
  //     http.Response response = await http.post(
  //       Uri.parse(uploadImageUrl),
  //       body: convert.jsonEncode(
  //         map,
  //       ),
  //       headers: {
  //         HttpHeaders.authorizationHeader: widget.user.token,
  //         "Accept": "application/json",
  //         "content-type": "application/json",
  //       },
  //     );
  //     print('statusCode: ${response.statusCode}');
  //     print('response.body : ' + response.body.toString());
  //     if (response.statusCode < 400) {
  //       var jsonResponse =
  //       convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
  //       print(jsonResponse);
  //       imageIds.add(jsonResponse['image_id']);
  //       counter++;
  //       if (images.length == counter) {
  //         setState(() {
  //           showSpinner = false;
  //         });
  //         bool haveUploadedUserIdentity = await checkUploaded();
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => IdentityScreen(
  //               villa: widget.villa,
  //               resortDescription: widget.resortDescription,
  //               resortIdentification: widget.resortIdentification,
  //               facilitation: widget.facilitation,
  //               user: widget.user,
  //               imageIds: imageIds,
  //               placeAddress: widget.placeAddress,
  //               haveUploadedUserIdentity: haveUploadedUserIdentity,
  //             ),
  //           ),
  //         );
  //       }
  //     } else {
  //       counter++;
  //       if (images.length == counter) {
  //         setState(() {
  //           showSpinner = false;
  //         });
  //         StaticMethods.showErrorDialog(
  //             context, 'An Error happened updating profile');
  //         // bool haveUploadedUserIdentity = await checkUploaded();
  //       }
  //       print(response.body);
  //     }
  //   } catch (e) {
  //     setState(() {
  //       showSpinner = false;
  //     });
  //     StaticMethods.printError(e.toString());
  //   }
  // }

  uploadFile(File file, String url) async {
    Dio dio = new Dio();
    // dio.post(uploadUrl, data: )
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
    }); // just like JS
    // formdata.add("photos", new MultipartFile(file, basename(file.path)));
    dio
        .post(
          url,
          data: formData,
          options: Options(
              method: 'POST',
              headers: {
                HttpHeaders.authorizationHeader: widget.user.token,
              },
              responseType: ResponseType.json // or ResponseType.JSON
              ),
        )
        .then((response) => print(response))
        .catchError((error) => print(error));
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
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final _picker = ImagePicker();
      PickedFile image = await _picker.getImage(source: source);

      final File selected = File(image.path);
      imageFile = selected;
    } catch (e) {
      print(e);
    }
  }

  onPlaceImageSelectPressed() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }

  uploadAll() async {

    Map map = Map();
    map['type'] = widget.villa;
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
    map['latitude'] = 0.0;
    map['longitude'] = 0.0;
    map['capacity'] = widget.resortIdentification.bCapacity;
    map['max_capacity'] = widget.resortIdentification.mCapacity;
    map['number_of_bathrooms'] = widget.resortIdentification.numBathrooms;
    map['number_of_showers'] = widget.resortIdentification.numShowers;
    map['number_of_single_beds'] = widget.resortIdentification.numSingleBeds;
    map['number_of_double_beds'] = widget.resortIdentification.numDoubleBeds;
    map['number_of_bedrooms'] = widget.resortIdentification.numRooms;
    map['image_id_list'] = widget.imageIds;
    map['facilities_list'] = widget.facilitation;
    // map['doc_id_list'] = ;

    http.Response response = await http.post(
      Uri.parse(url),
      body: convert.jsonEncode(map),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    if(response.statusCode < 400){
      print(response.statusCode);
    }
    else {
      print(response.statusCode);
      print(response.body);
    }
  }
}

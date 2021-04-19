import 'dart:typed_data';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../models/resort_description.dart';
import '../../static_methods.dart';
import '../../models/resort_identification.dart';
import '../../models/facilitation.dart';
import '../../models/gallery_item.dart';
import '../../models/place_address.dart';
import 'components/apartment_not_found_component.dart';
import 'components/bottom_container.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'components/add_gallery_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GalleryScreen extends StatefulWidget {
  final String villa;
  final ResortDescription resortDescription;
  final ResortIdentification resortIdentification;
  final Facilitation facilitation;
  final PlaceAddress placeAddress;
  final User user;

  GalleryScreen(
      {this.villa,
      @required this.user,
      this.resortDescription,
      this.resortIdentification,
      this.facilitation,
      this.placeAddress});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  Size size;
  FocusNode node;
  List<File> images = [];

  String imageUrl = '$mainUrl/api/villa/user/images/';
  String url = '$mainUrl/api/villa/user/';
  String identityUrl = '$mainUrl/api/villa/user/document/';

  int counter = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: StaticMethods.myAppBar('Gallery Screen', context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (images != null && images.length != 0) ...[
              AddGalleryItem(
                size: size,
                onAddPressed: () {
                  onImageSelectPressed();
                },
              ),
            ] else ...[
              SizedBox(
                height: size.height * 0.2,
              ),
            ],
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
                top: size.width * 0.05,
              ),
              child: customContainer(),
            ),
            if (images != null && images.length != 0) ...[
              BottomContainer(
                text: 'Submit & Continue',
                onPressed: () {
                  onPressed();
                },
              ),
            ] else ...[
              Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: (){
                        onImageSelectPressed();
                      },
                      child: Container(
                        // margin: EdgeInsets.all(20),
                        height: size.height * 0.4,
                        width: size.height * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Colors.blueGrey[400],
                          border: Border.all(
                            width: 1,
                              color: Colors.blueGrey[400],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              color: Colors.blueGrey[400],
                              size: size.height * 0.1,
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Text(
                              'Upload Accommodation pictures',
                              style: kBodyTextStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              'Upload At least one picture',
                              style: kBodyTextStyle.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  customContainer() {
    return buildGridView();
  }

  selectFromGallery() {
    _pickImage(ImageSource.gallery);
    Navigator.pop(context);
  }

  selectFromCamera() {
    _pickImage(ImageSource.camera);
    Navigator.pop(context);
  }

  void onImageSelectPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StaticMethods.myAlertDialog(selectFromCamera, selectFromGallery);
      },
    );
  }

  onPressed() {
    for (File file in images) {
      // getImageFileFromFiles(file);
      uploadImage(file);
    }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => GalleryScreen(
    //       villa: widget.villa,
    //       resortDescription: widget.resortDescription,
    //       resortIdentification: widget.resortIdentification,
    //       facilitation: widget.facilitation,
    //     ),
    //   ),
    // );
  }

  getData(File file) {
    print('getting');
    final result = file.path;
    print(result);
  }

  getImageFileFromFiles(File file) async {
    print(file.path);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final _picker = ImagePicker();
      PickedFile image = await _picker.getImage(source: source);

      final File selected = File(image.path);
      print('--------------------------------------------------------------');
      print(selected);
      setState(() {
        images.add(selected);
      });
    } catch (e) {
      print(e);
    }
  }

  uploadImage(File file) async {
    // setState(() {
    //   showSpinner = true;
    // });
    // print(user.token);
    print('in uploading images');
    Map map = Map();
    if (file != null) {
      String base64file = convert.base64Encode(file.readAsBytesSync());
      map['filename'] = file.path.split('/').last;
      map['image_file'] = base64file;
    }
    try {
      http.Response response = await http.post(
        Uri.parse(imageUrl),
        body: convert.jsonEncode(
          map,
        ),
        headers: {
          HttpHeaders.authorizationHeader: widget.user.token,
          "Accept": "application/json",
          "content-type": "application/json",
        },
      );
      // showSpinner = false;
      setState(() {});
      print('statusCode: ${response.statusCode}');
      print('response.body : ' + response.body.toString());
      if (response.statusCode < 400) {
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        print(jsonResponse);
      } else {
        StaticMethods.showErrorDialog(
            context, 'An Error happened updating profile');
        print(response.body);
      }
    } catch (e) {
      // showSpinner = false;
      setState(() {});
      StaticMethods.printError(e.toString());
    }
  }

  Widget buildGridView() {
    if (images != null && images.length != 0) {
      print('there are images');
      print('****************************************');
      print(images.length);
      print('****************************************');
      return Container(
        // height: size.height * 0.5,
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: List.generate(
            images.length,
            (index) {
              File file = images[index];
              return Material(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {
                      images.removeAt(index);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        file,
                        fit: BoxFit.cover,
                        width: (size.width * 0.3),
                        height: (size.width * 0.3),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      print('no images');
      return SizedBox();
    }
  }

  uploadInfo() {}
}

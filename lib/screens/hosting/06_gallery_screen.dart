import 'dart:typed_data';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/hosting/07_identity_screen.dart';
import 'package:loctio_booker/screens/hosting/components/image_container.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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
  List imageIds = [];
  String imageUrl = '$mainUrl/api/villa/user/images/';

  String checkUserUrl = '$mainUrl/api/account/check-document-existence';

  int counter = 0;
  bool showSpinner = false;

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
      body: ModalProgressHUD(
        progressIndicator: kMyProgressIndicator,
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
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
                ImageContainer(
                  height: size.height * 0.4,
                  width: size.height * 0.4,
                  size: size,
                  bodyText: 'Upload At least one picture',
                  headerText: 'Upload Accommodation pictures',
                  onImageSelectPressed: () {
                    onImageSelectPressed();
                  },
                ),
              ],
            ],
          ),
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

  onPressed() async {
    counter = 0;
    imageIds.clear();
    for (File file in images) {
      await uploadImage(file);
    }
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
    setState(() {
      showSpinner = true;
    });
    widget.user.printUser();
    print('in uploading images');
    Map map = Map();
    if (file != null) {
      String base64file = convert.base64Encode(file.readAsBytesSync());
      map['filename'] = file.path.split('/').last;
      map['image_file'] = base64file;
    }
    try {
      print('******** trying-to-upload...');
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
      print('statusCode: ${response.statusCode}');
      print('response.body : ' + response.body.toString());
      if (response.statusCode < 400) {
        var jsonResponse =
            convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
        print(jsonResponse);
        imageIds.add(jsonResponse['image_id']);
        counter++;
        if (images.length == counter) {
          setState(() {
            showSpinner = false;
          });
          bool haveUploadedUserIdentity = await checkUploaded();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IdentityScreen(
                villa: widget.villa,
                resortDescription: widget.resortDescription,
                resortIdentification: widget.resortIdentification,
                facilitation: widget.facilitation,
                user: widget.user,
                imageIds: imageIds,
                placeAddress: widget.placeAddress,
                haveUploadedUserIdentity: haveUploadedUserIdentity,
              ),
            ),
          );
        }
      } else {
        counter++;
        if (images.length == counter) {
          setState(() {
            showSpinner = false;
          });
          StaticMethods.showErrorDialog(
              context, 'An Error happened while uploading gallery');
          // bool haveUploadedUserIdentity = await checkUploaded();
        }
        print(response.body);
      }
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      StaticMethods.printError(e.toString());
    }
  }

  Future<bool> checkUploaded() async {
    http.Response response = await http.get(
      Uri.parse(checkUserUrl),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
      },
    );
    var jsonResponse = convert.jsonDecode(response.body);
    print('----------------------------------');
    print(jsonResponse);
    if(jsonResponse.toString() == 'No document exist!'){
      return false;
    }
    else{
      return true;
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
}

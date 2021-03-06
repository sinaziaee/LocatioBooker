import 'dart:typed_data';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/laws.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/hosting/09_identity_screen.dart';
import 'package:loctio_booker/screens/hosting/components/image_container.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../constants.dart';
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
import "package:latlong2/latlong.dart" as latLng;


class GalleryScreen extends StatefulWidget {
  final String villa;
  final ResortDescription resortDescription;
  final ResortIdentification resortIdentification;
  final Facilitation facilitation;
  final PlaceAddress placeAddress;
  final Key key = Key('resort_gallery_screen_key');
  final User user;
  final latLng.LatLng location;
  final Laws laws;

  GalleryScreen({
    this.villa,
    @required this.user,
    this.resortDescription,
    this.resortIdentification,
    this.facilitation,
    this.placeAddress,
    this.laws,
    this.location,
  });

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
      appBar: StaticMethods.myAppBar('Gallery Screen', context, widget.user),
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
              Center(
                child: Text(
                  (images.length < 8)
                      ? (images.length == 0)
                          ? 'Select at least 4 images'
                          : (images.length < 4)
                              ? 'Select ${4 - images.length} more images'
                              : 'You can Select ${8 - images.length} more images'
                      : 'You can\'t select more images',
                  style: kHeaderTextStyle.copyWith(
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
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
                  key: Key('submit_gallery'),
                  text: 'Submit & Continue',
                  onPressed: () {
                    onPressed();
                  },
                  isActivated: images.length >= 4,
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
    if (images.length >= 8) {
      return;
    }
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
    if (images.length < 4) {
      StaticMethods.showErrorDialog(
          context, 'Please select ${4 - images.length} more images');
      return;
    }
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
          // HttpHeaders.authorizationHeader: 'Token bab330f8321c61a9ba457fab4efc1b223c3f8731',
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
                laws: widget.laws,
                location: widget.location,
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
    if (jsonResponse.toString() == 'No document exist!') {
      return false;
    } else {
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
                child: Stack(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        showGallery(file);
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
                    Positioned(
                      right: 3,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            images.removeAt(index);
                          });
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
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

  showGallery(File file) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Image.file(
            file,
            width: (size.height > size.width)
                ? size.width * 0.8
                : size.height * 0.8,
            height: (size.height > size.width)
                ? size.width * 0.8
                : size.height * 0.8,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

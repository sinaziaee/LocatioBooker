import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../models/resort_description.dart';
import '../../static_methods.dart';
import '../../models/resort_identification.dart';
import '../../models/facilitation.dart';
import '../../models/gallery_item.dart';
import '../../models/place_address.dart';
import 'components/bottom_container.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'components/add_gallery_item.dart';

class GalleryScreen extends StatefulWidget {
  final String villa;
  final ResortDescription resortDescription;
  final ResortIdentification resortIdentification;
  final Facilitation facilitation;
  final PlaceAddress placeAddress;

  GalleryScreen(
      {this.villa,
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
  List<Asset> images = [];
  String _error;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    node = FocusScope.of(context);
    return Scaffold(
      appBar: StaticMethods.myAppBar('Gallery Screen', context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddGalleryItem(
              size: size,
              onAddPressed: () {
                loadAssets();
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
                top: size.width * 0.05,
              ),
              child: customContainer(),
            ),
            BottomContainer(
              text: 'Submit & Continue',
              onPressed: () {
                onPressed();
              },
            ),
          ],
        ),
      ),
    );
  }

  customContainer() {
    return buildGridView();
  }

  onPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryScreen(
          villa: widget.villa,
          resortDescription: widget.resortDescription,
          resortIdentification: widget.resortIdentification,
          facilitation: widget.facilitation,
        ),
      ),
    );
  }

  getData(Asset asset) async{
    final result = await asset.getByteData();
    print(result);
    // print('asset: ${asset}');
  }

//   uploadImages(Asset asset) async{
//     // string to uri
//     // Uri uri = Uri.parse('$_apiEndpoint/some/path');
//
// // create multipart request
//     MultipartRequest request = MultipartRequest("POST", uri);
//
//     ByteData byteData = await asset.getByteData();
//     List<int> imageData = byteData.buffer.asUint8List();
//
//     MultipartFile multipartFile = MultipartFile.fromBytes(
//       'photo',
//       imageData,
//       filename: 'some-file-name.jpg',
//       // contentType: MediaType("image", "jpg"),
//     );
//
// // add file to multipart
//     request.files.add(multipartFile);
// // send
//     var response = await request.send();
//   }

  Widget buildGridView() {
    if (images != null) {
      print('there are images');
      if(images != null && images.length != 0){
        getData(images[0]);
      }
      return Container(
        height: size.height * 0.5,
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(
            images.length,
            (index) {
              Asset asset = images[index];
              return Material(
                borderRadius: BorderRadius.circular(20),

                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: (){
                    setState(() {
                      images.removeAt(index);
                    });
                  },
                  child: Container(
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(20),
                    //   border: Border.all(
                    //     color: Colors.red,
                    //     width: 3,
                    //   ),
                    // ),
                    margin: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AssetThumb(
                        asset: asset,
                        width: (size.width * 0.3).round(),
                        height: (size.width * 0.3).round(),
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
      return Container(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey,
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 80,
          ),
        ),
      );
    }
  }

  Future<void> loadAssets() async {
    // setState(() {
    //   images = [];
    // });

    List<Asset> resultList = [];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 8 - images.length,
        enableCamera: true,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // images = resultList;
      images.addAll(resultList);
      if (error == null) _error = 'No Error Detected';
    });
  }
}

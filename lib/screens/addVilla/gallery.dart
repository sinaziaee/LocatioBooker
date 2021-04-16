import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class gallery extends StatefulWidget {
  static String id = 'gallery_id';

  @override
  _galleryState createState() => _galleryState();
}

class _galleryState extends State<gallery> {

  bool showSpinner = true;
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';


  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
      ),

      body: ModalProgressHUD(
        progressIndicator: kMyProgressIndicator,
        inAsyncCall: showSpinner,

        child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Center(
                  child: Text('Enter your Villa Images : ',
                    style: kBodyTextStyle,
                  ),
                ),

                Center(
                  child: ElevatedButton(
                    child: Text("Pick images"),
                    onPressed: loadAssets,


                  ),
                ),
                Expanded(
                  child: buildGridView(),
                )

              ],
            ),
        ),
      ),
    );
  }
}

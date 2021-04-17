import 'package:flutter/material.dart';
import '../../models/resort_description.dart';
import '../../static_methods.dart';
import '../../models/resort_identification.dart';
import '../../models/facilitation.dart';
import '../../models/gallery_item.dart';
import '../../models/place_address.dart';
import 'components/bottom_container.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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
}

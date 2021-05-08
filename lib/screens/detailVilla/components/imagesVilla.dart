import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/villa.dart';

class imagesVilla extends StatefulWidget {
  final Villa villa;

  imagesVilla(this.villa);

  @override
  _imagesVillaState createState() => _imagesVillaState();
}

class _imagesVillaState extends State<imagesVilla> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    print("length : ${widget.villa.images}");

    return Column(
      children: [
        SizedBox(
          width: 300,
          height: 200,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.villa.id.toString(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  mainUrl + widget.villa.images[selectedImage],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.villa.images.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 48.0,
        width: 48.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.purple.withOpacity(selectedImage == index ? 1 : 0),
          ),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(mainUrl + widget.villa.images[index])),
      ),
    );
  }
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

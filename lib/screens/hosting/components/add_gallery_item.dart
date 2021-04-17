import 'package:flutter/material.dart';

class AddGalleryItem extends StatelessWidget {

  final Size size;
  final Function onAddPressed;
  AddGalleryItem({@required this.size, this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width * 0.3,
      width: size.width * 0.3,
      margin: EdgeInsets.all(size.height * 0.03),
      child: Material(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onAddPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 100,
            ),
          ),
        ),
      ),
    );
  }
}

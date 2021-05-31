import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {

  bool isFavorite;
  LikeButton({this.isFavorite});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    if(widget.isFavorite == null){
      widget.isFavorite = !widget.isFavorite;
    }
    return Positioned(
      right: 15,
      top: 15,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            setState(() {
              widget.isFavorite = !widget.isFavorite;
            });
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: (widget.isFavorite)
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(Icons.favorite_border_outlined),
          ),
        ),
      ),
    );
  }
}

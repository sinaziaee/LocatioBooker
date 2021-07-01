import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/models/user.dart';
import '../../../static_methods.dart';

class LikeButton extends StatefulWidget {
  bool isFavorite;
  final User user;
  final int villaId;

  LikeButton({
    this.isFavorite,
    @required this.user,
    @required this.villaId,
  });

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.isFavorite == null) {
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
              onFavoritePressed(widget.villaId);
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

  onFavoritePressed(int villaId) async {
    widget.isFavorite = !widget.isFavorite;
    http.Response response = await StaticMethods.changeFavoriteStatus(
      villaId: villaId,
      user: widget.user,
      status: widget.isFavorite,
    );
    if (response != null) {
      setState(() {});
    } //
    else {}
  }
}

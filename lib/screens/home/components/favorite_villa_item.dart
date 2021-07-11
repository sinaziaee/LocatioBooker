import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/favorite_villa.dart';
import '../../../models/search_model.dart';

class FavoriteVillaItem extends StatelessWidget {
  final Size size;
  final FavoriteVilla favoriteVilla;
  final Function onVillaPressed, onFavoritePressed;
  final bool last;

  FavoriteVillaItem({
    this.size,
    this.favoriteVilla,
    this.onVillaPressed,
    this.last,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    print(favoriteVilla.rate);
    return Container(
      height: size.width * 0.6,
      margin: EdgeInsets.only(
        left: 10,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onVillaPressed,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    width: size.width * 0.45,
                    height: size.width * 0.4,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/home_def.jpg'),
                    image: (!favoriteVilla.url.endsWith('null'))
                        ? NetworkImage('$mainUrl${favoriteVilla.url}')
                        : AssetImage('assets/images/home_def.jpg'),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  ' ${favoriteVilla.name}',
                  style: kBody1TextStyle.copyWith(),
                ),
                Text(
                  ' ${favoriteVilla.country}, ${favoriteVilla.city}',
                  style: kBody3TextStyle.copyWith(),
                ),
                Row(
                  children: [
                    Text(
                      ' ${favoriteVilla.pricePerNight}\$ ',
                      style: kBody3TextStyle.copyWith(),
                    ),
                    Text(
                      '/ per night',
                      style: kBody3TextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      ' ${favoriteVilla.rate ?? 5.0}',
                      style: kBody3TextStyle.copyWith(),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow[800],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: onFavoritePressed,
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

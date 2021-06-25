import 'package:flutter/material.dart';
import 'package:loctio_booker/models/search_model.dart';
import 'package:loctio_booker/models/user.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:loctio_booker/screens/detailVilla/detail_villa_screen.dart';
import '../../../constants.dart';

class ResultMapItem extends StatelessWidget {
  final SearchModel villa;
  final User user;
  final latLng.LatLng loc;
  final Function onPressed;
  ResultMapItem({
    this.villa,
    this.loc,
    this.onPressed,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
      ),
      child: Stack(
        children: [
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DetailVillaScreen(user: user, villaId: villa.villaId,
                      );
                    },
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      child: FadeInImage(
                        placeholder: AssetImage('assets/images/home_def.jpg'),
                        image: (villa.url != null &&
                                villa.url.length != 0)
                            ? NetworkImage('$mainUrl${villa.url}')
                            : AssetImage('assets/images/home_def.jpg'),
                        fit: BoxFit.cover,
                        height: 60,
                        width: 80,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              (villa.rate != null)
                                  ? villa.rate.toString()
                                  : 3.toString(),
                              style: kBody1TextStyle.copyWith(),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                        Text(
                          this.villa.name,
                          style: kBody1TextStyle.copyWith(),
                        ),
                        Row(
                          children: [
                            Text(
                              '${this.villa.pricePerNight.toString()}\$',
                              style: kBody1TextStyle.copyWith(),
                            ),
                            Text(
                              '/per night',
                              style: kBody2TextStyle.copyWith(fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 1,
            top: 7,
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.location_on_outlined,
                size: 30,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

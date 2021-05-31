import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/place.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/detailVilla/detail_villa_screen.dart';

class CustomPlaceItem extends StatefulWidget {
  final Place place;
  final Size size;
  bool isFavorite;
  final User user;

  CustomPlaceItem({
    this.place,
    this.size,
    this.isFavorite,
    this.user,
  });

  @override
  _CustomPlaceItemState createState() => _CustomPlaceItemState();
}

class _CustomPlaceItemState extends State<CustomPlaceItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.isFavorite == null) {
      widget.isFavorite = false;
    }
    print('$mainUrl${widget.place.images[0]}');
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailVillaScreen(user: widget.user, villaId: widget.place.id,
              );
            },
          ),
        );
      },
      child: Container(
        height: 380,
        width: 300,
        margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/home_def.jpg'),
                      image: NetworkImage(
                        '$mainUrl${widget.place.images[0]}',
                      ),
                      // image: AssetImage('assets/images/home_def.jpg'),
                      width: widget.size.width * 0.9,
                      height: widget.size.width * 0.6,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
              child: Row(
                children: [
                  Text(
                    widget.place.name,
                    style: kBody1TextStyle.copyWith(),
                  ),
                  Spacer(),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    widget.place.rate.toString(),
                    style: kBody1TextStyle.copyWith(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.room_outlined,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        ' ${widget.place.country} , ${widget.place.city}',
                        style: kBody2TextStyle.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.bed_outlined,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                    Text(
                      ' ${widget.place.numberOfBedrooms} rooms',
                      style: kBody2TextStyle.copyWith(
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.person_pin_circle_outlined,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        ' ${widget.place.maxCapacity} people max',
                        style: kBody2TextStyle.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 5, right: 10),
              child: Text(
                  'Starting price for each night (up to ${widget.place.maxCapacity} people)'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 5, right: 10),
              child: Row(
                children: [
                  Text(
                    '${widget.place.price} dollars ',
                    style: kBody1TextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '/ each night',
                    style: kBody1TextStyle.copyWith(
                        color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/villa.dart';
import '../../../models/search_model.dart';

class ReservePlaceItem extends StatelessWidget {
  final Size size;
  final Villa villa;
  final Function onPressed;
  final bool last;

  ReservePlaceItem({this.size, this.villa, this.onPressed, this.last});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: 70,
              margin: EdgeInsets.only(),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 3,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            height: 70,
                            width: 60,
                            fit: BoxFit.cover,
                            placeholder:
                                AssetImage('assets/images/home_def.jpg'),
                            image: (villa.images != null)
                                ? NetworkImage('$mainUrl${villa.images[0]}')
                                : AssetImage('assets/images/home_def.jpg'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(
                              flex: 1,
                            ),
                            SizedBox(
                              width: size.width - 160,
                              child: Text(
                                villa.name,
                                // textWidthBasis: TextWidthBasis.parent,
                                style: TextStyle(
                                  // color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              '${villa.country}, ${villa.city}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              'Reserved in June 2 to 10 2020',
                              style: kBody3TextStyle.copyWith(
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${villa.rate.toString()} ',
                                  style: kBody3TextStyle.copyWith(),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[800],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Visibility(
          visible: !last,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            height: 0.5,
            color: Colors.grey,
            width: size.width,
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
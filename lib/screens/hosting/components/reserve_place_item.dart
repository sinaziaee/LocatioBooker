import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/static_methods.dart';
import '../../../models/search_model.dart';

class ReservePlaceItem extends StatelessWidget {
  final Size size;
  final Villa villa;
  final Function onPressed, onCancelPressed;
  final bool last;
  final List dates;

  ReservePlaceItem({
    this.size,
    this.villa,
    this.onPressed,
    this.last,
    this.dates,
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Material(
              color: Colors.white,
              child: InkWell(
                onTap: onPressed,
                child: Container(
                  height: 90,
                  margin: EdgeInsets.only(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 3,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage(
                                height: 80,
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
                                  width: size.width - 170,
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
                                Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${villa.rate ?? '0.0'} ',
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '   ${StaticMethods.getDateRange(dates)}',
                        style: kBody3TextStyle.copyWith(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 20,
              child: Material(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: onCancelPressed,
                  child: Container(
                    height: 30,
                    width: 60,
                    // child: Icon(
                    //   Icons.hide_source_outlined,
                    //   color: Colors.blueGrey,
                    // ),
                    child: Text(
                      'Cancel book',
                      style: kBody3TextStyle.copyWith(
                        fontSize: 10,
                        color: Colors.blueGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
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

import 'package:flutter/material.dart';
import 'package:loctio_booker/models/villa.dart';

import '../../../constants.dart';

class ReserveHeader extends StatelessWidget {
  final Villa villa;
  final String imageUrl;

  ReserveHeader({this.villa, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              width: 180,
              height: 120,
              fit: BoxFit.cover,
              // placeholder: NetworkImage('$mainUrl${villa.images[0]}'),
              placeholder: NetworkImage('$mainUrl${imageUrl}'),
              image: AssetImage('assets/images/home_image_def.jpg'),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5, bottom: 10),
                  child: Text(
                    '${villa.name}',
                    style: kBody1TextStyle.copyWith(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    Expanded(
                      child: Text(
                        '${villa.country}, ${villa.state}, ${villa.city}',
                        style: kBody1TextStyle.copyWith(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    Text(
                      '${villa.rate ?? 4}',
                      style: kBody1TextStyle.copyWith(
                        color: Colors.blueGrey[700],
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

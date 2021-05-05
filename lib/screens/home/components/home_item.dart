import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';

class HomePlaceItem extends StatelessWidget {
  final String url, name, country, state, city;
  final int cost;
  final double rate;

  HomePlaceItem({
    this.city,
    this.country,
    this.name,
    this.state,
    this.rate,
    this.url,
    @required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: EdgeInsets.only(
        left: 20,
        right: 5,
        top: 5,
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              placeholder: AssetImage('assets/images/home_def.jpg'),
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  '$country, $city',
                  style: kBody3TextStyle.copyWith(),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 20,
                child: Text(
                  '${rate.toString()}',
                  style: kBody3TextStyle.copyWith(),
                ),
              ),
              Icon(
                Icons.star_border,
                color: Colors.yellow,
                size: 20,
              ),
            ],
          ),
          Text(
            name ?? 'name',
            style: kBody2TextStyle.copyWith(),
          ),
          Text(
            '${cost.toString()}\$',
            style: kBody1TextStyle.copyWith(),
          ),
        ],
      ),
    );
  }
}

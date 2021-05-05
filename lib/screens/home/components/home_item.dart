import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/search_model.dart';

class HomePlaceItem extends StatelessWidget {

  final SearchModel searchModel;

  HomePlaceItem({
    this.searchModel,
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
              image: (searchModel.url != null) ? NetworkImage(searchModel.url) : AssetImage('assets/images/home_def.jpg'),
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
                  '${searchModel.country}, ${searchModel.city}',
                  style: kBody3TextStyle.copyWith(),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 20,
                child: Text(
                  '${searchModel.rate.toString()}',
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
            searchModel.name ?? 'name',
            style: kBody2TextStyle.copyWith(),
          ),
          Text(
            '${searchModel.pricePerNight.toString()}\$',
            style: kBody1TextStyle.copyWith(),
          ),
        ],
      ),
    );
  }
}

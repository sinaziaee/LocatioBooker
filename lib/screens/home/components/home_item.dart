import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/search_model.dart';
import 'package:loctio_booker/models/user.dart';
import '../../detailVilla/detail_villa_screen.dart';

class HomePlaceItem extends StatelessWidget {
  final SearchModel searchModel;
  final User user;

  HomePlaceItem({
    this.searchModel,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    searchModel.rate = (searchModel.rate == null) ? 5.0 : searchModel.rate;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          onTapped(context, user, searchModel.villaId);
        },
        child: Container(
          width: 220,
          height: 250,
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
                  width: 220,
                  height: 150,
                  placeholder: AssetImage('assets/images/home_def.jpg'),
                  image: (searchModel.url.endsWith('null'))
                      ? AssetImage('assets/images/home_def.jpg')
                      : NetworkImage(searchModel.url),
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
                '${searchModel.pricePerNight.toString()}\$ per night',
                style: kBody1TextStyle.copyWith(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapped(BuildContext context, User user, int villaId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailVillaScreen(user: user, villaId: villaId,
          );
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/models/favorite_villa.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/detailVilla/detail_villa_screen.dart';
import 'package:loctio_booker/screens/home/components/favorite_villa_item.dart';
import 'package:loctio_booker/screens/hosting/components/nothing_found.dart';
import 'package:loctio_booker/static_methods.dart';
import 'dart:convert' as convert;
import '../../../constants.dart';

class FavoriteVillasPage extends StatefulWidget {
  final User user;

  FavoriteVillasPage(this.user);

  @override
  _FavoriteVillasPageState createState() => _FavoriteVillasPageState();
}

class _FavoriteVillasPageState extends State<FavoriteVillasPage> {
  Size size;

  // todo: change link
  String url = '$mainUrl/api/villa/user/likes/';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Your Favorite Villas',
            style: kHeaderTextStyle.copyWith(),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder(
              future: getFavorites(),
              builder: (context, snapshot) {
                try {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    http.Response response = snapshot.data;
                    if (response.statusCode < 400) {
                      var jsonResponse = convert.json
                          .decode(convert.utf8.decode(response.bodyBytes));
                      List list = jsonResponse;
                      if (list == null || list.length == 0) {
                        return NothingFound(
                          size: size,
                          text1:
                              'You haven\'t added any villa to your favorites',
                          text2: '',
                          image: 'assets/images/resort/no_house.jpg',
                        );
                      }
                      return GridView.builder(
                        itemCount: list.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (size.height > size.width) ? 2 : 4,
                            childAspectRatio: 2 / 3),
                        itemBuilder: (BuildContext context, int index) {
                          Map result = list[index];
                          FavoriteVilla item = FavoriteVilla(
                            url: result['images'][0],
                            villaId: result['villa_id'],
                            pricePerNight: result['price_per_night'],
                            name: result['name'],
                            city: result['city'],
                            rate: result['rate'],
                            state: result['state'],
                            country: result['country'],
                            favorite: result['like'],
                          );
                          return FavoriteVillaItem(
                            size: size,
                            favoriteVilla: item,
                            last: (index + 1 == list.length),
                            onVillaPressed: () {
                              onVillaPressed(
                                item,
                              );
                            },
                            onFavoritePressed: () {
                              onFavoritePressed(item);
                            },
                          );
                        },
                      );
                    } //
                    else {
                      return Center(
                        child: Text('An error getting list of favorite places'),
                      );
                    }
                  } //
                  else {
                    return Center(
                      child: kMyProgressIndicator,
                    );
                  }
                } //
                catch (e) {
                  print(e);
                  return Center(
                    child: Text('An error getting list of favorite places'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<http.Response> getFavorites() async {
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
      },
    );
    return response;
  }

  onVillaPressed(FavoriteVilla favoriteVilla) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailVillaScreen(
            user: widget.user,
            villaId: favoriteVilla.villaId,
          );
        },
      ),
    );
  }

  onFavoritePressed(FavoriteVilla favoriteVilla) async {
    http.Response response = await StaticMethods.changeFavoriteStatus(
      villaId: favoriteVilla.villaId,
      user: widget.user,
      status: false,
    );
    if (response != null) {
      setState(() {});
    } //
    else {}
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/models/favorite_villa.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/detailVilla/detail_villa_screen.dart';
import 'package:loctio_booker/screens/home/components/favorite_villa_item.dart';
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
      child: FutureBuilder(
        future: getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            http.Response response = snapshot.data;
            print(url);
            print('---------------------------');
            print(response.statusCode);
            print(response.body);
            if (response.statusCode < 400) {
              var jsonResponse =
                  convert.json.decode(convert.utf8.decode(response.bodyBytes));
              Map result = jsonResponse;
              List list = result['data'];
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return FavoriteVillaItem(
                    size: size,
                    favoriteVilla: list[index],
                    last: (index + 1 == list.length),
                    onVillaPressed: () {
                      onVillaPressed(
                        FavoriteVilla(
                          url: list[index].url,
                          villaId: list[index].villaId,
                          pricePerNight: list[index].pricePerNight,
                          name: list[index].name,
                          city: list[index].city,
                          rate: list[index].rate,
                          state: list[index].state,
                          country: list[index].country,
                          favorite: list[index].favorite,
                        ),
                      );
                    },
                  );
                },
              );
            } //
            else {
              return Center(
                child: Text('An error getting list of chat rooms'),
              );
            }
          } else {
            return Center(
              child: kMyProgressIndicator,
            );
          }
        },
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

  onFavoritePressed() {}
}

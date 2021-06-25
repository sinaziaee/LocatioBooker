import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/search_model.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/detailVilla/detail_villa_screen.dart';
import 'package:loctio_booker/screens/home/components/search_item.dart';
import 'package:loctio_booker/screens/hosting/components/apartment_not_found_component.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'custom_drawer.dart';

class SearchAllPlacesScreen extends StatefulWidget {
  static String id = 'search_place_screen';
  final User user;

  SearchAllPlacesScreen(this.user);

  @override
  _SearchAllPlacesScreenState createState() => _SearchAllPlacesScreenState();
}

class _SearchAllPlacesScreenState extends State<SearchAllPlacesScreen> {
  Size size;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String url = '$mainUrl/api/villa/search/?number_of_villa=10';
  String country = '', state = '', city = '';

  @override
  Widget build(BuildContext context) {
    print(
        '$url${(country != null && country.length != 0) ? '&country=$country' : ''}'
            '${(state != null && state.length != 0) ? '&state=$state' : ''}'
            '${(city != null && city.length != 0) ? '&city=$city' : ''}');
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: _drawerKey,
      // assign key to Scaffold
      endDrawer: CustomDrawer(
        cityValue: city,
        countryValue: country,
        stateValue: state,
        onCityChanged: (value) {
          onCityPressed(value);
        },
        onStateChanged: (value) {
          onStatePressed(value);
        },
        onCountryChanged: (value) {
          onCountryPressed(value);
        },
        user: widget.user,
      ),
      backgroundColor: Colors.lightBlue,
      appBar: PreferredSize(
        child: Container(
          margin: EdgeInsets.only(
            top: 40,
          ),
          color: Colors.lightBlue,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Material(
                      child: IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          size: 25,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.only(top: 5),
                      icon: Icon(
                        Icons.filter_list,
                        size: 30,
                      ),
                      onPressed: () {
                        _drawerKey.currentState.openEndDrawer();
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        preferredSize: Size(size.height, 100),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: FutureBuilder(
          future: http.get(
            Uri.parse(
                '$url${(country != null && country.length != 0) ? '&country=$country' : ''}'
                    '${(state != null && state.length != 0) ? '&state=$state' : ''}'
                    '${(city != null && city.length != 0) ? '&city=$city' : ''}'),
            headers: {
              HttpHeaders.authorizationHeader: widget.user.token,
            },
          ),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              http.Response response = snapshot.data;
              var jsonResponse = convert.jsonDecode(response.body);
              List<SearchModel> list = [];
              int count = 0;
              var data = jsonResponse['data'];
              for (var each in data) {
                count++;
                list.add(SearchModel.fromMap(each));
              }
              if (count == 0) {
                return Center(
                  child: ApartmentNotFoundComponent(
                    size: size,
                  ),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return SearchComponent(
                    size: size,
                    searchModel: list[index],
                    last: (index + 1 == count),
                    onPressed: () {
                      onPressed(SearchModel(
                        url: list[index].url,
                        villaId: list[index].villaId,
                        pricePerNight: list[index].pricePerNight,
                        name: list[index].name,
                        city: list[index].city,
                        rate: list[index].rate,
                        state: list[index].state,
                        country: list[index].country,
                      ));
                    },
                  );
                },
                itemCount: count,
              );
            } else {
              return Container(
                height: size.height,
                width: size.width,
                child: Center(child: kMyProgressIndicator),
              );
            }
          },
        ),
      ),
    );
  }

  onPressed(SearchModel searchModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailVillaScreen(user: widget.user, villaId: searchModel.villaId,
          );
        },
      ),
    );
  }

  onCountryPressed(String country) {
    setState(() {
      this.country = country;
    });
  }

  onStatePressed(String state) {
    setState(() {
      this.state = state;
    });
  }

  onCityPressed(String city) {
    setState(() {
      this.city = city;
    });
  }
}

class Data extends ChangeNotifier {
  String text;
  final User user;

  Data(this.text, this.user);

  void changeText(String newText) {
    this.text = newText;
    notifyListeners();
  }

  void clear() {
    this.text = null;
    notifyListeners();
  }
}

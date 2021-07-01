import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/detailVilla/detail_villa_screen.dart';
import 'package:loctio_booker/screens/home/date_picker_screen.dart';
import 'package:loctio_booker/screens/hosting/components/nothing_found.dart';
import 'package:loctio_booker/screens/hosting/components/my_textfield.dart';
import 'components/search_item.dart';
import '../../models/search_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'components/custom_drawer.dart';
import 'components/search_site_component.dart';

class SearchCityScreen extends StatefulWidget {
  static String id = 'search_place_screen';
  final User user;
  final String category;

  SearchCityScreen(this.user, this.category);

  @override
  _SearchCityScreenState createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  Size size;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  // String url = '$mainUrl/api/villa/search/?number_of_villa=10&page=1';
  String url = '$mainUrl/api/villa/most-popular-city/show/?number_of_city=10';

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
                    IconButton(
                      color: Colors.white,
                      icon: Icon(
                        Icons.chevron_left,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
          future: getPlaces(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              http.Response response = snapshot.data;
              var jsonResponse =
                  convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
              // List<SearchModel> list = [];
              List list = [];
              int count = 0;
              var data = jsonResponse['data'];
              for (var each in data) {
                count++;
                list.add(each);
              }
              if (count == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/img-not-found.png'),
                      Text(
                        'Place not found',
                        style: kBody1TextStyle.copyWith(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return SiteComponent(
                    city: list[index]['city'] ?? 'city',
                    onTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DatePickerScreen(
                              user: widget.user,
                              city: list[index]['city'],
                            );
                          },
                        ),
                      );
                    },
                    placesNum: list[index]['no_villa'],
                    last: index != count - 1,
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

  getPlaces() async {
    http.Response response = await http.get(
      Uri.parse(
          '$url${(country != null && country.length != 0) ? '&country=$country' : ''}'
          '${(state != null && state.length != 0) ? '&state=$state' : ''}'
          '${(city != null && city.length != 0) ? '&city=$city' : ''}'),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
      },
    );
    return response;
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
    // Navigator.pushNamed(context, DetailVillaScreen.id, arguments: {
    //   'user': widget.user,
    //   'id': searchModel.villaId,
    // });
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

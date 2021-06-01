import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/models/search_model.dart';
import 'package:loctio_booker/models/user.dart';
import 'dart:convert' as convert;
import '../../../constants.dart';
import 'home_item.dart';
import 'home_item_mock.dart';
import '../components/custom_map.dart';
import '../../../components/villa_not_found.dart';


class HighRatePlace extends StatelessWidget {
  final String highRatePlacesUrl =
      '$mainUrl/api/villa/most-rated/show/?page=1&number_of_villa=10';
  final User user;
  final Size size;
  final Function onHighRatePressed;

  HighRatePlace(this.user, this.size, this.onHighRatePressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            child: Row(
              children: [
                Text(
                  'High rate places',
                  style: kBodyTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: onHighRatePressed,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Text('See All'),
                    ),
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  http.Response response = snapshot.data;
                  if (response.statusCode == 401) {
                    return invalidTokenWidget();
                  }
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
                      child: VillaNotFound(
                        size: size,
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return HomePlaceItem(
                        searchModel: list[index],
                        user: user,
                      );
                    },
                    itemCount: count,
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 150,
                          minHeight: 120,
                          maxWidth: 300,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 5,
                            top: 5,
                            bottom: 5,
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.grey),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: 5,
                  );
                }
              },
              future: http.get(
                Uri.parse(highRatePlacesUrl),
                headers: {
                  HttpHeaders.authorizationHeader: user.token,
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // CustomMap(size),
        ],
      ),
    );
  }

  Widget invalidTokenWidget(){
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
            size: 100,
          ),
          Text(
            'Invalid Token',
            style: kBody1TextStyle,
          ),
        ],
      ),
    );
  }

}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/models/search_model.dart';
import 'package:loctio_booker/models/user.dart';
import 'dart:convert' as convert;
import '../../../constants.dart';
import 'home_item.dart';
import 'home_item_mock.dart';
import '../../../components/villa_not_found.dart';

class MostReservedPlace extends StatelessWidget {
  final String mostReservedPlacesUrl =
      '$mainUrl/api/villa/most-registered/show/?page=1&number_of_villa=10';
  final Size size;
  final User user;
  final Function onMostReservedPressed;

  MostReservedPlace(this.user, this.size, this.onMostReservedPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            child: Row(
              children: [
                Text(
                  'Most reserved places',
                  style: kBodyTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: onMostReservedPressed,
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
                  // print(response.statusCode);
                  // print(response.body);
                  if (response.statusCode == 401) {
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
                  var jsonResponse = convert.jsonDecode(response.body);
                  List<SearchModel> list1 = [];
                  List<SearchModel> list2 = [];
                  List<SearchModel> list = [];
                  int count = 0;
                  var data = jsonResponse['data'];
                  for (int i = 0; i < data.length; i++) {
                    count++;
                    list.add(SearchModel.fromMap(data[i]));
                    if (i % 2 == 0) {
                      list1.add(SearchModel.fromMap(data[i]));
                    } else {
                      list2.add(SearchModel.fromMap(data[i]));
                    }
                  }
                  if (list1.length == 0 && list2.length == 0) {
                    return Center(
                      child: VillaNotFound(
                        size: size,
                      ),
                    );
                  }

                  int newCount = (count / 2).round();

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          HomePlaceItem(
                            searchModel: list1[index],
                            user: user,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if (index <  list2.length) ...[
                            HomePlaceItem(
                              searchModel: list2[index],
                              user: user,
                            ),
                          ] else
                            ...[
                              SizedBox(),
                            ],
                        ],
                      );
                    },
                    itemCount: newCount,
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          HomePlaceItemMock(),
                          SizedBox(
                            height: 10,
                          ),
                          HomePlaceItemMock()
                        ],
                      );
                    },
                    itemCount: 5,
                  );
                }
              },
              future: http.get(
                Uri.parse(mostReservedPlacesUrl),
                headers: {
                  HttpHeaders.authorizationHeader: user.token,
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget invalidTokenWidget() {
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

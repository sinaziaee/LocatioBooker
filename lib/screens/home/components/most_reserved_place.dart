import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/models/search_model.dart';
import 'package:loctio_booker/models/user.dart';
import 'dart:convert' as convert;
import '../../../constants.dart';
import 'home_item.dart';
import 'home_item_mock.dart';

class MostReservedPlace extends StatelessWidget {


  final String mostReservedPlacesUrl =
      '$mainUrl/api/villa/search/?page=1&number_of_villa=10';

  final User user;

  MostReservedPlace(this.user);

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
                  'High rate places',
                  style: kBodyTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Container(
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
                  print(response.statusCode);
                  // print(response.body);
                  var jsonResponse = convert.jsonDecode(response.body);
                  List<SearchModel> list = [];
                  int count = 0;
                  var data = jsonResponse['data'];
                  for (var each in data) {
                    print(each);
                    count++;
                    list.add(SearchModel.fromMap(each));
                  }
                  if (count == 0) {
                    return Center(
                      child: Text(
                        'No villa found',
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          HomePlaceItem(
                            searchModel: list[index],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HomePlaceItem(
                            searchModel: list[index],
                          ),
                        ],
                      );
                    },
                    itemCount: count,
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
}

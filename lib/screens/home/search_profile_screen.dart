import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loctio_booker/components/person_item.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/authentication/components/my_textfield_without_node.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'components/custom_profile_not_found.dart';
import 'components/custom_profile_search.dart';
import '../../constants.dart';

class SearchProfileScreen extends StatefulWidget {
  static String id = 'search_profile_screen';

  @override
  _SearchProfileScreenState createState() => _SearchProfileScreenState();
}

class _SearchProfileScreenState extends State<SearchProfileScreen> {
  TextEditingController searchController;
  String url = '$mainUrl/api/account/properties/all';
  User user;
  Map args;
  Size size;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    size = MediaQuery.of(context).size;
    user = args['user'];
    // print('$url${(searchController.text.length != 0) ? '?search=${searchController.text}' : ''}');
    print(
        '$url?search=${(searchController.text.length != 0) ? searchController.text : null}');
    return Scaffold(
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
                  height: 30,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        cursorWidth: 1,
                        style: TextStyle(),
                        cursorColor: Colors.black,
                        decoration: InputDecoration.collapsed(
                          border: InputBorder.none,
                          hintText: 'Where are you going?',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: searchController.text.isNotEmpty,
                      child: IconButton(
                        color: Colors.grey,
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        // Scaffold.of(context).openDrawer();
                        // setState(() {
                        //
                        // });
                      },
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
        preferredSize: Size(size.height, 80),
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: http.get(
            Uri.parse(
                '$url?search=${(searchController.text.length != 0) ? searchController.text : null}'),
            headers: {
              HttpHeaders.authorizationHeader: user.token,
            },
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              http.Response response = snapshot.data;
              print(response.statusCode);
              print(response.body);
              var jsonResponse = convert.jsonDecode(response.body);
              List<User> mapList = [];
              int count = 0;
              for (Map map in jsonResponse) {
                count++;
                User user = User.fromJson(map);
                mapList.add(user);
              }
              if (count == 0 &&
                  '$url?search=${(searchController.text.length != 0) ? searchController.text : null}'
                      .endsWith('null')) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: CustomProfileSearch(),
                  ),
                );
              }
              if (count == 0) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: CustomProfileNotFound(),
                  ),
                );
              }
              if (response.statusCode < 400) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return itemBuilder(mapList[index], !(index == count - 1));
                  },
                  itemCount: count,
                );
              } else {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: Text('An Error happened'),
                  ),
                );
              }
            } else {
              return Container(
                color: Colors.white,
                child: Center(
                  child: kMyProgressIndicator,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget itemBuilder(User user, bool isVisible) {
    return PersonItem(user, size, isVisible);
  }
}

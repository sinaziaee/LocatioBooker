import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loctio_booker/components/person_item.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/authentication/components/my_textfield_without_node.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
    return Scaffold(
      appBar: AppBar(
        title: MyTestFieldWithoutNode(
          hint: 'search',
          isPassword: false,
          isLast: true,
          controller: searchController,
          color: Colors.white,
          onChanged: (String sth) {
            setState(() {});
          },
        ),
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: size.height * 0.04,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: http.get(
          Uri.parse(
              '$url${(searchController.text.length != 0) ? '?search=${searchController.text}' : ''}'),
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
            if (count == 0) {
              return Center(
                child: Text('No accounts found'),
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
              return Center(
                child: Text('An Error happened'),
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

  Widget itemBuilder(User user, bool isVisible) {
    return PersonItem(user, size, isVisible);
  }
}

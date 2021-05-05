import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/hosting/components/apartment_not_found_component.dart';
import 'package:loctio_booker/screens/hosting/components/my_textfield.dart';
import 'components/search_item.dart';
import '../../models/search_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class SearchSpaceScreen extends StatefulWidget {
  static String id = 'search_place_screen';
  final User user;
  final String category;
  SearchSpaceScreen(this.user, this.category);

  @override
  _SearchSpaceScreenState createState() => _SearchSpaceScreenState();
}

class _SearchSpaceScreenState extends State<SearchSpaceScreen> {
  Size size;

  String url = '$mainUrl/api/villa/search/?number_of_villa=10';

  TextEditingController searchController;

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
    size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: Column(),
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
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: FutureBuilder(
          future: http.get(
            Uri.parse(url),
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
                print(each);
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
                    last: (index+1 == count),
                    onPressed: () {
                      onPressed(SearchModel());
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
    print("pressed");
  }

}

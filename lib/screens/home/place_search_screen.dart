import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'components/search_item.dart';
import '../../models/search_model.dart';

class SearchSpaceScreen extends StatefulWidget {
  static String id = 'search_place_screen';

  @override
  _SearchSpaceScreenState createState() => _SearchSpaceScreenState();
}

class _SearchSpaceScreenState extends State<SearchSpaceScreen> {

  Size size;

  String url = '$mainUrl/api/villa/search/?number_of_villa=10';

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SearchComponent(
              size: size,
              searchModel: SearchModel(),
            ),
          ],
        ),
      ),
    );
  }
}



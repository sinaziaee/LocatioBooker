import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/authentication/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/search_place_screen.dart';
import '../../../constants.dart';
import "package:latlong/latlong.dart" as latLng;
import '../components/home_screen_search_bar.dart';
import '../components/home_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../models/search_model.dart';
import '../components/home_item_mock.dart';
import '../components/high_rate_place.dart';
import '../components/most_reserved_place.dart';
import '../components/custom_search.dart';

class HomePage extends StatefulWidget {
  final Size size;
  final User user;

  HomePage(this.size, this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double fixedHeight = 300;

  visibleSearchBar(double height) {
    return Visibility(
      visible: ((1 - (height / fixedHeight) == 0.72)),
      child: IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        onPressed: () {
          onSearchPressed();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double top = constraints.biggest.height;
            // print(top);
            // print((1 - (top / fixedHeight) == 0.72) ? 1 : 1 - (top / fixedHeight));
            return FlexibleSpaceBar(
              centerTitle: true,
              title: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: (1 - (top / fixedHeight) == 0.72)
                    ? 1
                    : 1 - (top / fixedHeight),
                curve: Curves.easeOutQuint,
                child: CustomHomeSearchBar(
                  size: widget.size,
                  onSearchPressed: () {
                    onSearchPressed();
                  },
                ),
              ),
              background: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/home_image_def.jpg',
                      fit: BoxFit.fitWidth,
                      width: widget.size.width,
                    ),
                  ),
                  Positioned(
                    child: CustomSearch(
                      size: widget.size,
                      onPressed: () {
                        onSearchPressed();
                      },
                    ),
                    top: 20,
                  ),
                ],
              ),
            );
          }),
          pinned: true,
          floating: true,
          snap: true,
          elevation: 0.0,
          collapsedHeight: 75,
          expandedHeight: (widget.size.height > widget.size.width) ? fixedHeight : 200,
          stretch: false,
        ),
        SliverFixedExtentList(
          // itemExtent: widget.size.height * 0.73,
          itemExtent: 580,
          delegate: SliverChildListDelegate(
            [
              MostReservedPlace(widget.user, widget.size, () {
                onMorePressed('');
              }),
              HighRatePlace(widget.user, widget.size, () {
                onMorePressed('');
              }),
            ],
          ),
        ),
      ],
    );
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.popAndPushNamed(context, LoginScreen.id);
  }

  void onSearchPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchSpaceScreen(widget.user, null),
      ),
    );
  }

  onMorePressed(String search) {
    print('more pressed');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchSpaceScreen(widget.user, search),
      ),
    );
  }
}

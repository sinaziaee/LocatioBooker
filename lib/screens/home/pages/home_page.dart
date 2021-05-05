import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/authentication/components/my_textfield_without_node.dart';
import 'package:loctio_booker/screens/authentication/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/place_search_screen.dart';
import '../../../constants.dart';
import "package:latlong/latlong.dart" as latLng;
import '../components/home_screen_search_bar.dart';
import '../components/home_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  final Size size;
  final User user;

  HomePage(this.size, this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double fixedHeight = 300;

  String highRatePlacesUrl = '';
  String mostReservedPlacesUrl = '';

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
            print(top);
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
                      'assets/images/home.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        onSearchPressed();
                      },
                      iconSize: 50,
                    ),
                    right: 2,
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
          expandedHeight: fixedHeight,
          stretch: false,
        ),
        SliverFixedExtentList(
          itemExtent: widget.size.height,
          delegate: SliverChildListDelegate(
            [
              // Container(color: Colors.white),
              // Container(
              //   child: customMap(context),
              //   height: 300,
              //   // width: 200,
              // ),
              // Container(color: Colors.purple),
              mostReservedPlaces(),
              // highRatePlace(),
              // Container(color: Colors.green),
              // Container(color: Colors.orange),
              // Container(color: Colors.yellow),
              // Container(color: Colors.pink),
            ],
          ),
        ),
      ],
    );
  }

  Widget highRatePlace() {
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
                  return SizedBox();
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return HomePlaceItem(
                        cost: 10,
                        url: '$tempHouseImage',
                        name: 'single room suite',
                        city: 'Tehran',
                        rate: 4.3,
                        country: 'Iran',
                        state: 'Tehran',
                      );
                    },
                    itemCount: 5,
                  );
                }
              },
              future: http.get(
                Uri.parse(highRatePlacesUrl),
                headers: {
                  HttpHeaders.authorizationHeader: widget.user.token,
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mostReservedPlaces() {
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
                  return SizedBox();
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          HomePlaceItem(
                            cost: 10,
                            url: '$tempHouseImage',
                            name: 'single room suite',
                            city: 'Tehran',
                            rate: 4.3,
                            country: 'Iran',
                            state: 'Tehran',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HomePlaceItem(
                            cost: 10,
                            url: '$tempHouseImage',
                            name: 'single room suite',
                            city: 'Tehran',
                            rate: 4.3,
                            country: 'Iran',
                            state: 'Tehran',
                          )
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
                  HttpHeaders.authorizationHeader: widget.user.token,
                },
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.purple,
          ),
        ],
      ),
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
        builder: (context) => SearchSpaceScreen(widget.user),
      ),
    );
  }

  Widget customMap(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        // center: LatLng(51.5, -0.09),
        center: latLng.LatLng(36.314845, 59.555513),
        zoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 40.0,
              height: 40.0,
              point: latLng.LatLng(36.314845, 59.555513),
              builder: (ctx) => Container(
                // child: FlutterLogo(
                //
                // ),
                // child: Image.asset('assets/images/marker.png', height: 20, width: 20,),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.red.shade900,
                ),
                // child: Container(
                //   height: 40,
                //   width: 20,
                //   decoration: BoxDecoration(
                //     color: Colors.red,
                //     borderRadius: BorderRadius.only(
                //       bottomLeft: Radius.circular(10),
                //       bottomRight: Radius.circular(10),
                //     ),
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

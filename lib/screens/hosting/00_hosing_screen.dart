import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/detail_villa_screen.dart';
import 'package:loctio_booker/screens/hosting/components/host_place_item.dart';
import 'package:loctio_booker/static_methods.dart';
import '01_resort_type_screen.dart';
import 'components/nothing_found.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'components/reserve_place_item.dart';

class HostingScreen extends StatefulWidget {
  static String id = 'hosting_screen';

  final User user;
  final Key key = Key('hosting_screen_key');

  HostingScreen(this.user);

  @override
  _HostingScreenState createState() => _HostingScreenState();
}

class _HostingScreenState extends State<HostingScreen>
    with TickerProviderStateMixin {
  Size size;
  String getAllUsersVillasUrl = '$mainUrl/api/villa/user/';
  String hostingUrl = '$mainUrl/api/villa/user/me/?hosted';
  String reservedUrl = '$mainUrl/api/villa/user/me/?reserved';

  List tabsNames = [
    'Hosting',
    'Reserved',
  ];
  int tabIndex = 0;

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    // tabController.animation
    //   ..addListener(() {
    //     setState(() {
    //       tabIndex = (tabController.animation.value).round();
    //       print('_tabController.animation.value: ${tabController.animation.value}');
    //       print('_currentIndex: $tabController');
    //     });
    //   });
    tabController.addListener(() {
      setState(() {
        tabIndex = (tabController.animation.value).round();
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    getAllUsersVilla();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 50,
          backgroundColor: Colors.blueGrey,
          bottom: TabBar(
            controller: tabController,
            onTap: (newIndex) {
              // setState(() {
              tabIndex = newIndex;
              // });
            },
            indicatorColor: Colors.white,
            tabs: List.generate(
              2,
              (index) {
                return new Tab(
                  text: tabsNames[index],
                );
              },
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: List.generate(
            2,
            (tabIndex) {
              return FutureBuilder(
                future: getInfo(this.tabIndex),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    http.Response response = snapshot.data;
                    if (response.statusCode < 400) {
                      var jsonResponse = convert.json.decode(response.body);
                      print(jsonResponse);
                      List mapList = [];
                      int count = 0;
                      for (Map each in jsonResponse['data']) {
                        mapList.add(each);
                        count++;
                      }
                      if (count == 0) {
                        return Center(
                          child: NothingFound(
                            image: 'assets/images/resort/no_house.jpg',
                            size: size,
                            text1: (this.tabIndex == 0)
                                ? 'You haven\'t hosted any villa'
                                : 'You haven\'t reserved any villa',
                            text2: '',
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: count,
                        itemBuilder: (context, index) {
                          if (this.tabIndex == 0) {
                            Villa villa = Villa.fromJson(mapList[index]);
                            return HostPlaceItem(
                              size: size,
                              villa: villa,
                              last: count == index + 1,
                              onPressed: () {
                                onHostItemPressed(villa);
                              },
                            );
                          } //
                          else {
                            Villa villa = Villa.fromJson(mapList[index]);
                            return ReservePlaceItem(
                              size: size,
                              villa: villa,
                              last: count == index + 1,
                              onPressed: () {
                                onHostItemPressed(villa);
                              },
                            );
                          }
                        },
                      );
                    } //
                    else {
                      return Center(
                        child: Text(
                          'An error occurred',
                          style: kHeaderTextStyle.copyWith(),
                        ),
                      );
                    }
                    // return Container();
                  } else {
                    return Center(
                      child: kMyProgressIndicator,
                    );
                  }
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResortTypeScreen(widget.user),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  getAllUsersVilla() async {
    http.Response response = await http.get(
      Uri.parse(getAllUsersVillasUrl),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
      },
    );
    var jsonResponse = convert.json.decode(response.body);
    // print(jsonResponse);
  }

  Future<http.Response> getInfo(int index) async {
    print(index);
    if (index == 0) {
      // print(hostingUrl);
      try {
        http.Response response = await http.get(
          Uri.parse(hostingUrl),
          headers: {
            HttpHeaders.authorizationHeader: widget.user.token,
          },
        );
        return response;
      } catch (e) {
        print(e);
        return null;
      }
    } //
    else {
      // print(reservedUrl);
      try {
        http.Response response = await http.get(
          Uri.parse(reservedUrl),
          headers: {
            HttpHeaders.authorizationHeader: widget.user.token,
          },
        );
        return response;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  void onHostItemPressed(Villa villa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailVillaScreen(villaId: villa.villaId, user: widget.user);
        },
      ),
    );
  }

  void onReservedItemPressed(int villaId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailVillaScreen(villaId: villaId, user: widget.user);
        },
      ),
    );
  }
}

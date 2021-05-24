import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loctio_booker/models/facilitation.dart';
import 'package:loctio_booker/models/laws.dart';
import 'package:loctio_booker/models/place_address.dart';
import 'package:loctio_booker/models/resort_description.dart';
import 'package:loctio_booker/models/resort_identification.dart';
import 'package:loctio_booker/models/user.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:loctio_booker/screens/hosting/components/bottom_container.dart';
import 'package:loctio_booker/screens/hosting/components/law_item.dart';
import 'package:loctio_booker/static_methods.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '08_gallery_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LawsScreen extends StatelessWidget {
  final String villa;
  final ResortDescription resortDescription;
  final ResortIdentification resortIdentification;
  final Facilitation facilitation;
  final PlaceAddress placeAddress;
  final Key key = Key('laws_screen_key');
  final User user;
  final latLng.LatLng location;

  LawsScreen({
    this.villa,
    @required this.user,
    this.resortDescription,
    this.resortIdentification,
    this.facilitation,
    this.placeAddress,
    this.location,
  });

  Laws laws = Laws();
  Size size;
  String lawsUrl = '$mainUrl/api/villa/special-rules/';
  List<bool> checkList = [];
  List<int> lawIdList = [];
  List<Map> mapList = [];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.myAppBar('Laws Screen', context, user),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Text(
              'Check the rules which need to be followed.',
              style: kBody1TextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getLaws(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  http.Response response = snapshot.data;
                  print(response.body);
                  var jsonResponse = convert.json.decode(response.body);
                  mapList = [];
                  int mapCount = 0;
                  for (var each in jsonResponse) {
                    // mapList.add(each['text']);
                    mapList.add(each);
                    print(each);
                    mapCount++;
                  }
                  checkList.clear();
                  for (int i = 0; i < mapCount; i++) {
                    checkList.add(false);
                  }
                  return ListView.builder(
                    itemCount: mapCount,
                    itemBuilder: (context, index) {
                      return LawItem(
                        text: mapList[index]['text'],
                        // state: checkList[index],
                        list: checkList,
                        index: index,
                      );
                    },
                  );
                } else {
                  return Center(
                    child: kMyProgressIndicator,
                  );
                }
              },
            ),
          ),
          BottomContainer(
            key: Key('laws_bottom'),
            size: size,
            text: 'Submit & Continue',
            isActivated: true,
            onPressed: () {
              postLawItems();
              print('${location.latitude}, ${location.longitude}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalleryScreen(
                    villa: villa,
                    resortDescription: resortDescription,
                    resortIdentification: resortIdentification,
                    facilitation: facilitation,
                    placeAddress: placeAddress,
                    user: user,
                    location: location,
                    laws: laws,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void postLawItems(){
    laws.lawsList = [];
    print(checkList);
    for(int i=0;i<mapList.length;i++){
      if(checkList[i] == true){
        laws.lawsList.add(mapList[i]['rule_id']);
        print('**');
      }
    }
    print(laws.lawsList);
  }

  Future<http.Response> getLaws() async {
    return await http.get(
      Uri.parse(lawsUrl),
      headers: {
        HttpHeaders.authorizationHeader: user.token,
      },
    );
  }
}

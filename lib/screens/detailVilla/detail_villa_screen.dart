import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/chat/chat_screen.dart';
import 'package:loctio_booker/screens/detailVilla/components2/back_icon.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/screens/detailVilla/components2/detail_date_range.dart';
import 'package:loctio_booker/screens/detailVilla/components2/detail_fascilitation.dart';
import 'package:loctio_booker/screens/detailVilla/components2/detail_header_component.dart';
import 'package:loctio_booker/screens/detailVilla/components2/detail_images.dart';
import 'package:loctio_booker/screens/detailVilla/components2/detail_row_item.dart';
import 'package:loctio_booker/screens/detailVilla/components2/detail_service_body.dart';
import 'package:loctio_booker/screens/detailVilla/components2/reserve_button.dart';
import 'package:loctio_booker/static_methods.dart';
import 'dart:convert' as convert;
import '../../constants.dart';
import 'components2/detail_description.dart';
import 'components2/detail_divider.dart';
import 'components2/detail_laws.dart';
import 'components2/detail_map.dart';
import 'components2/like_button.dart';
import 'package:latlong2/latlong.dart' as latLng;

class DetailVillaScreen extends StatefulWidget {
  static String id = 'detail_villa_screen';
  final int villaId;
  final User user;
  bool isFavorite = false;

  DetailVillaScreen({@required this.villaId, @required this.user});

  @override
  _DetailVillaScreenState createState() => _DetailVillaScreenState();
}

class _DetailVillaScreenState extends State<DetailVillaScreen> {
  String allLawsUrl = '$mainUrl/api/villa/fixed-rules/';
  String villaUrl = "$mainUrl/api/villa/user/?villa_id=";
  String addChatUrl = '$mainUrl/api/chat/add/';
  Size size;
  Villa villa;

  List<String> rulesList = [];
  List<String> imagesUrlList = [];

  String defImageUrl;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                FutureBuilder(
                  future: getVilla(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    DetailImages(
                                      imagesList: imagesUrlList,
                                      size: size,
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    DetailHeader(
                                      villa: villa,
                                    ),
                                    Container(
                                      height: 0.5,
                                      color: Colors.grey,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 20,
                                      ),
                                    ),
                                    DetailServiceBody(
                                      villa: villa,
                                      onChatPressed: () {
                                        onChatPressed();
                                      },
                                      user: widget.user,
                                    ),
                                    DetailRowItem(
                                      value:
                                          '${villa.area} base area, ${villa.numberOfBedrooms} rooms',
                                      type: 'About Accommodation',
                                      iconData: FontAwesomeIcons.home,
                                    ),
                                    DetailRowItem(
                                      value:
                                          'Up to ${villa.maxCapacity} people ( ${villa.capacity} people + ${villa.maxCapacity - villa.capacity} more people )',
                                      type: 'Capacity',
                                      iconData: Icons.people,
                                    ),
                                    DetailRowItem(
                                      value:
                                          '${villa.numberOfSingleBeds} single beds, ${villa.numberOfDoubleBeds} double beds',
                                      type: 'Bed Services',
                                      iconData: FontAwesomeIcons.bed,
                                    ),
                                    DetailRowItem(
                                      value:
                                          '${villa.numberOfBathrooms} bathrooms, ${villa.numberOfShowers} showers',
                                      type: 'WC services',
                                      iconData: FontAwesomeIcons.bath,
                                    ),
                                    DetailDivider(),
                                    DetailDescription(
                                      description: villa.description,
                                    ),
                                    DetailDivider(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    DetailFacilitation(
                                      facilitationItems: villa.facilities,
                                      size: size,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    DetailDivider(),
                                    DetailsMap(
                                      location: latLng.LatLng(
                                        villa.latitude,
                                        villa.longitude,
                                      ),
                                    ),
                                    DetailDivider(),
                                    // DetailCalendar(),
                                    DetailRange(),
                                    // DetailTableCalendar(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    DetailDivider(),
                                    DetailLaws(
                                      size: size,
                                      villa: villa,
                                      fixedRules: rulesList,
                                    ),
                                    // DetailDivider(),
                                  ],
                                ),
                              ),
                            ),
                            ReserveButton(
                              villa: villa,
                              imageUrl: defImageUrl,
                              user: widget.user,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Center(
                          child: kMyProgressIndicator,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            BackButtonItem(),
            LikeButton(
              isFavorite: widget.isFavorite,
            ),
          ],
        ),
      ),
    );
  }

  Future<Villa> getVilla() async {
    print('$villaUrl${widget.villaId}');
    try {
      http.Response response = await http.get(
        Uri.parse('$villaUrl${widget.villaId}'),
        headers: {
          HttpHeaders.authorizationHeader: widget.user.token,
        },
      );
      if (response.statusCode < 400) {
        var jsonResponse =
            convert.json.decode(convert.utf8.decode(response.bodyBytes));
        // print('--------------------------------');
        // print(jsonResponse);
        this.villa = Villa.fromJson(jsonResponse);
        imagesUrlList.clear();
        defImageUrl = villa.images[0];
        // print(defImageUrl);
        for (int i = 0; i < villa.images.length; i++) {
          imagesUrlList.add(villa.images[i].toString());
        }
        getFixedRules();
        return villa;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      StaticMethods.showErrorDialog(context, "Error loading villa");
      return null;
    }
  }

  Future<bool> getFixedRules() async {
    rulesList.clear();
    try {
      http.Response response = await http.get(
        Uri.parse(allLawsUrl),
        headers: {
          HttpHeaders.authorizationHeader: widget.user.token,
        },
      );
      if (response.statusCode < 400) {
        var jsonResponse =
            convert.json.decode(convert.utf8.decode(response.bodyBytes));
        for (var each in jsonResponse) {
          rulesList.add(each.toString());
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      StaticMethods.showErrorDialog(context, 'Error on getting fixed rules');
      return false;
    }
  }

  onChatPressed() async {
    print(addChatUrl);
    Map userMap = Map();
    userMap['contact'] = villa.ownerId;
    http.Response response = await http.post(
      Uri.parse(addChatUrl),
      headers: {
        HttpHeaders.authorizationHeader: widget.user.token,
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: convert.json.encode(
        userMap,
      ),
    );
    Map jsonResponse = convert.json.decode(response.body);
    Map data = jsonResponse['data'];
    print(data);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ChatScreen(
            user: widget.user,
            chatRoomId: data['chat_id'],
            otherUser: '${data['first_name']} ${data['last_name']}',
            otherUserImageUrl: data['image'],
          );
        },
      ),
    );
  }

}

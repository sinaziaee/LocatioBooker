import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/components2/back_icon.dart';
import 'package:http/http.dart' as http;
import 'package:loctio_booker/screens/detailVilla/components2/detail_fascilitation.dart';
import 'package:loctio_booker/screens/detailVilla/components2/detail_header_component.dart';
import 'package:loctio_booker/screens/detailVilla/components2/detail_row_item.dart';
import 'package:loctio_booker/screens/detailVilla/components2/detail_service_body.dart';
import 'package:loctio_booker/screens/detailVilla/components2/reserve_button.dart';
import 'dart:convert' as convert;
import '../../constants.dart';
import 'components2/detail_description.dart';
import 'components2/detail_laws.dart';
import 'components2/detail_map.dart';
import 'components2/like_button.dart';
import 'package:latlong/latlong.dart' as latLng;

class DetailVillaScreen extends StatefulWidget {
  final int villaId;
  final User user;
  bool isFavorite = false;

  DetailVillaScreen({@required this.villaId, @required this.user});

  @override
  _DetailVillaScreenState createState() => _DetailVillaScreenState();
}

class _DetailVillaScreenState extends State<DetailVillaScreen> {

  Size size;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    Villa villa = Villa(
      country: 'Iran',
      state: 'Tehran',
      city: 'Tehran',
      name: 'Kolbeh',
      price: 100,
      maxCapacity: 5,
      longitude: 20.0,
      latitude: 50.0,
      images: [],
      id: 1,
      address: 'Malek Abad, Farhad Street, 17th street',
      area: 100,
      capacity: 4,
      description:
          'The best Villa in iran available for best people of iran . so this is sth else',
      postalCode: '1231231231',
      facilities: [],
      number_of_bathrooms: 3,
      number_of_bedrooms: 4,
      number_of_double_beds: 3,
      number_of_showers: 2,
      number_of_single_beds: 2,
      owner: 'Sina Ziaee',
      ri: null,
      type: 'Coastal',
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        ),
                        DetailRowItem(
                          value:
                              '${villa.area} base area, ${villa.number_of_bedrooms} rooms',
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
                              '${villa.number_of_single_beds} single beds, ${villa.number_of_double_beds} double beds',
                          type: 'Bed Services',
                          iconData: FontAwesomeIcons.bed,
                        ),
                        DetailRowItem(
                          value:
                              '${villa.number_of_bathrooms} bathrooms, ${villa.number_of_showers} showers',
                          type: 'WC services',
                          iconData: FontAwesomeIcons.bath,
                        ),
                        Divider(
                          indent: 20,
                          endIndent: 20,
                        ),
                        DetailDescription(
                          description: villa.description,
                        ),
                        Divider(
                          indent: 20,
                          endIndent: 20,
                        ),
                        DetailFascilitaion(
                          fascilitationItems: villa.facilities,
                        ),
                        DetailsMap(
                          location:
                              latLng.LatLng(villa.latitude, villa.longitude),
                        ),
                        Divider(
                          indent: 20,
                          endIndent: 20,
                        ),
                        DetailLaws(
                          size: size,
                        ),
                      ],
                    ),
                  ),
                ),
                ReserveButton(
                  villa: villa,
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
}

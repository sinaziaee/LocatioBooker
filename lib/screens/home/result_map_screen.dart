import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:loctio_booker/models/search_model.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:latlong/latlong.dart' as latLng;
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/detailVillaScreen.dart';
import 'package:loctio_booker/screens/home/components/result_map_item.dart';
import 'package:loctio_booker/static_methods.dart';

import '../../constants.dart';

class ResultMapScreen extends StatefulWidget {
  final User user;
  final Key key = Key('result_map_screen');
  final List mapListLocations;
  final List<SearchModel> mapListVilla;
  latLng.LatLng location;
  final int count;

  ResultMapScreen({
    this.user,
    this.location,
    this.mapListLocations,
    this.mapListVilla,
    this.count,
  });

  @override
  _ResultMapScreenState createState() => _ResultMapScreenState();
}

class _ResultMapScreenState extends State<ResultMapScreen>
    with TickerProviderStateMixin {
  Size size;
  MapController mapController = MapController();

  void animatedMapMove(latLng.LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          latLng.LatLng(
              _latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.mapListVilla);
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.myAppBar('Map Selection', context, widget.user,
          isVisible: false),
      body: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: size.height - 60,
            ),
            child: Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Expanded(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center: widget.location,
                    zoom: 12.0,
                  ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    MarkerLayerOptions(
                      markers: getAllLocations(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            left: 1,
            bottom: 10,
            child: Container(
              height: 110,
              width: size.width,
              color: Colors.transparent,
              child: ListView.builder(
                itemCount: widget.count,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ResultMapItem(
                    onPressed: () {},
                    user: widget.user,
                    loc: latLng.LatLng(
                        widget.mapListLocations[index]['latitude'],
                        widget.mapListLocations[index]['longitude']),
                    villa: widget.mapListVilla[index],
                  );
                  // return Padding(
                  //   padding: EdgeInsets.only(
                  //     left: 10,
                  //   ),
                  //   child: Stack(
                  //     children: [
                  //       Material(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(10),
                  //         child: InkWell(
                  //           borderRadius: BorderRadius.circular(10),
                  //           onTap: () {
                  //             print(widget.mapListVilla[index].villaId
                  //                 .toString());
                  //             Navigator.pushNamed(
                  //               context,
                  //               detailVillaScreen.id,
                  //               arguments: {
                  //                 'user': widget.user,
                  //                 'id': widget.mapListVilla[index].villaId,
                  //               },
                  //             );
                  //           },
                  //           child: Container(
                  //             margin: EdgeInsets.only(right: 10),
                  //             padding: EdgeInsets.symmetric(
                  //               horizontal: 10,
                  //               vertical: 20,
                  //             ),
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             child: Row(
                  //               children: [
                  //                 ClipRRect(
                  //                   child: FadeInImage(
                  //                     placeholder: AssetImage(
                  //                         'assets/images/home_def.jpg'),
                  //                     image: (widget.mapListVilla[index].url !=
                  //                                 null &&
                  //                             widget.mapListVilla[index].url
                  //                                     .length !=
                  //                                 0)
                  //                         ? NetworkImage(
                  //                             widget.mapListVilla[index].url)
                  //                         : AssetImage(
                  //                             'assets/images/home_def.jpg'),
                  //                     fit: BoxFit.cover,
                  //                     height: 60,
                  //                     width: 80,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(5),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Column(
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     Row(
                  //                       children: [
                  //                         Text(
                  //                           (widget.mapListVilla[index].rate !=
                  //                                   null)
                  //                               ? widget
                  //                                   .mapListVilla[index].rate
                  //                                   .toString()
                  //                               : 3.toString(),
                  //                           style: kBody1TextStyle.copyWith(),
                  //                         ),
                  //                         Icon(
                  //                           Icons.star,
                  //                           color: Colors.yellow,
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     Text(
                  //                       widget.mapListVilla[index].name,
                  //                       style: kBody1TextStyle.copyWith(),
                  //                     ),
                  //                     Row(
                  //                       children: [
                  //                         Text(
                  //                           '${widget.mapListVilla[index].pricePerNight.toString()}\$',
                  //                           style: kBody1TextStyle.copyWith(),
                  //                         ),
                  //                         Text(
                  //                           '/per night',
                  //                           style: kBody2TextStyle.copyWith(
                  //                               fontSize: 11),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         right: 1,
                  //         top: 15,
                  //         child: IconButton(
                  //           onPressed: () {
                  //             print('=============================');
                  //             latLng.LatLng loc = latLng.LatLng(widget.mapListLocations[index]['latitude'], widget.mapListLocations[index]['longitude']);
                  //             print(loc);
                  //             print('=============================');
                  //             animatedMapMove(loc, 14);
                  //           },
                  //           icon: Icon(
                  //             Icons.location_on_outlined,
                  //             size: 30,
                  //             color: Colors.grey[700],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Marker> getAllLocations() {
    List locList = [];
    List<Marker> markerList = [];
    for (Map each in widget.mapListLocations) {
      latLng.LatLng loc = latLng.LatLng(each['latitude'], each['longitude']);
      locList.add(loc);
      markerList.add(
        Marker(
          width: 60.0,
          height: 30.0,
          point: loc,
          builder: (ctx) => Container(
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Material(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  // setState(() {
                  //   widget.location = loc;
                  // });
                  // mapController.move(loc, 14);
                  animatedMapMove(loc, 14);
                  // mapController..value()
                  // mapController.moveAndRotate(loc, 14, 10);
                },
                child: Center(
                  child: Text(
                    '${each['price_per_night'].toString()}\$',
                    textAlign: TextAlign.center,
                    style: kBody1TextStyle.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    // print(markerList);
    return markerList;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:loctio_booker/models/search_model.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:latlong/latlong.dart' as latLng;
import 'package:loctio_booker/models/villa.dart';
import 'package:loctio_booker/screens/detailVilla/detail_villa_screen.dart';
import 'package:loctio_booker/screens/home/components/result_map_item.dart';
import 'package:loctio_booker/static_methods.dart';

import '../../constants.dart';

ScrollController scrollController = ScrollController();

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
    size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Stack(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: size.height,
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
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ResultMapItem(
                    onPressed: () {
                      animatedMapMove(
                          latLng.LatLng(
                              widget.mapListLocations[index]['latitude'],
                              widget.mapListLocations[index]['longitude']),
                          14);
                    },
                    user: widget.user,
                    loc: latLng.LatLng(
                        widget.mapListLocations[index]['latitude'],
                        widget.mapListLocations[index]['longitude']),
                    villa: widget.mapListVilla[index],
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 5,
            child: SafeArea(
              child: Material(
                color: Colors.grey[700],
                shape: CircleBorder(),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                    ),
                  ),
                ),
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
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    for (int index = 0; index < widget.count; index++) {
      print(widget.mapListVilla[index].url);
      latLng.LatLng loc = latLng.LatLng(
          widget.mapListLocations[index]['latitude'],
          widget.mapListLocations[index]['longitude']);
      locList.add(loc);
      markerList.add(
        Marker(
          width: 60.0,
          height: 30.0,
          point: loc,
          builder: (ctx) =>
              Container(
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
                      // todo: animate to specific child index
                      animatedMapMove(loc, 14);
                      scrollController.animateTo(150 * index * 1.0,
                          duration: Duration(microseconds: 1000),
                          curve: Curves.ease);
                    },
                    child: Center(
                      child: Text(
                        '${widget.mapListLocations[index]['price_per_night']
                            .toString()}\$',
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
    return markerList;
  }
}

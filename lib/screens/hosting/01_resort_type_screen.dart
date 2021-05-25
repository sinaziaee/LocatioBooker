import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/models/user.dart';

import '../../constants.dart';
import '../../static_methods.dart';
import 'components/hosting_resort_type_item.dart';
import '02_resort_description_screen.dart';

class ResortTypeScreen extends StatefulWidget {
  final User user;
  final Key key = Key('resort_type_screen_key');

  ResortTypeScreen(this.user);

  @override
  _ResortTypeScreenState createState() => _ResortTypeScreenState();
}

class _ResortTypeScreenState extends State<ResortTypeScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.myAppBar('Resort Type Screen', context, widget.user),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: (size.height > size.width)
                  ? size.height * 0.02
                  : size.width * 0.04,
            ),
            Padding(
              key: Key('padding in resort type screen'),
              padding: EdgeInsets.only(
                  left: size.width * 0.05, right: size.width * 0.05),
              child: Text(
                'What area is your residence located in?',
                style: kHeaderTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: (size.height > size.width)
                      ? size.width * 0.042
                      : size.height * 0.048,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: (size.height > size.width)
                  ? size.height * 0.02
                  : size.width * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HostingResortItem(
                  key: Key(ResortType.coastal),
                  onPressed: () {
                    onPressed(ResortType.coastal);
                  },
                  size: size,
                  title: ResortType.coastal,
                  assetName: 'assets/images/category/beach.png',
                ),
                HostingResortItem(
                  key: Key(ResortType.urban),
                  onPressed: () {
                    onPressed(ResortType.urban);
                  },
                  size: size,
                  title: ResortType.urban,
                  assetName: 'assets/images/category/urban.png',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HostingResortItem(
                  key: Key(ResortType.motel),
                  onPressed: () {
                    onPressed(ResortType.motel);
                  },
                  size: size,
                  title: ResortType.motel,
                  assetName: 'assets/images/category/motel.png',
                ),
                HostingResortItem(
                  key: Key(ResortType.mountainous),
                  onPressed: () {
                    onPressed(ResortType.mountainous);
                  },
                  size: size,
                  title: ResortType.mountainous,
                  assetName: 'assets/images/category/mountainous.png',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HostingResortItem(
                  key: Key(ResortType.desert),
                  onPressed: () {
                    onPressed(ResortType.desert);
                  },
                  size: size,
                  title: ResortType.desert,
                  assetName: 'assets/images/category/desert.png',
                ),
                HostingResortItem(
                  key: Key(ResortType.rural),
                  onPressed: () {
                    onPressed(ResortType.rural);
                  },
                  size: size,
                  title: ResortType.rural,
                  assetName: 'assets/images/category/rural.png',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HostingResortItem(
                  key: Key(ResortType.suburban),
                  onPressed: () {
                    onPressed(ResortType.suburban);
                  },
                  size: size,
                  title: ResortType.suburban,
                  assetName: 'assets/images/category/suburban.png',
                ),
                HostingResortItem(
                  key: Key(ResortType.wild),
                  onPressed: () {
                    onPressed(ResortType.wild);
                  },
                  size: size,
                  title: ResortType.wild,
                  assetName: 'assets/images/category/wild.png',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onPressed(String villa) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResortDescriptionScreen(
                villa,
                widget.user,
              )),
    );
  }
}

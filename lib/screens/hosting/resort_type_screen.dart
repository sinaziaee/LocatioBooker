import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../static_methods.dart';
import 'components/hosting_resort_type_item.dart';
import 'resort_description_screen.dart';

class ResortTypeScreen extends StatefulWidget {
  @override
  _ResortTypeScreenState createState() => _ResortTypeScreenState();
}

class _ResortTypeScreenState extends State<ResortTypeScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.myAppBar('Resort Type Screen', context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
                  child: Text(
                    'What area is your residence located in?',
                    style: kHeaderTextStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.048,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HostingResortItem(
                  onPressed: (){
                    onPressed(ResortType.coastal);
                  },
                  size: size,
                  title: ResortType.coastal,
                  assetName: 'assets/images/as.jpg',
                ),
                HostingResortItem(
                  onPressed: (){
                    onPressed(ResortType.urban);
                  },
                  size: size,
                  title: ResortType.urban,
                  assetName: 'assets/images/as.jpg',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HostingResortItem(
                  onPressed: (){
                    onPressed(ResortType.forest);
                  },
                  size: size,
                  title: AccommodationType.motel,
                  assetName: 'assets/images/as.jpg',
                ),
                HostingResortItem(
                  onPressed: (){
                    onPressed(ResortType.mountainous);
                  },
                  size: size,
                  title: ResortType.mountainous,
                  assetName: 'assets/images/as.jpg',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HostingResortItem(
                  onPressed: (){
                    onPressed(ResortType.desert);
                  },
                  size: size,
                  title: ResortType.desert,
                  assetName: 'assets/images/as.jpg',
                ),
                HostingResortItem(
                  onPressed: (){
                    onPressed(ResortType.rural);
                  },
                  size: size,
                  title: ResortType.rural,
                  assetName: 'assets/images/as.jpg',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onPressed(String villa){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => ResortDescriptionScreen(
        villa,
      )),
    );
  }
}

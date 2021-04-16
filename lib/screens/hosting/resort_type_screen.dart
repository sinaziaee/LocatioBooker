import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../static_methods.dart';
import 'components/hosting_resort_type_item.dart';
import '02_resort_description_screen.dart';

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
                  assetName: 'assets/images/category/beach.png',
                ),
                HostingResortItem(
                  onPressed: (){
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
                  onPressed: (){
                    onPressed(ResortType.forest);
                  },
                  size: size,
                  title: AccommodationType.motel,
                  assetName: 'assets/images/category/motel.png',
                ),
                HostingResortItem(
                  onPressed: (){
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
                  onPressed: (){
                    onPressed(ResortType.desert);
                  },
                  size: size,
                  title: ResortType.desert,
                  assetName: 'assets/images/category/desert.png',
                ),
                HostingResortItem(
                  onPressed: (){
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
                  onPressed: (){
                    onPressed(ResortType.wild);
                  },
                  size: size,
                  title: ResortType.suburban,
                  assetName: 'assets/images/category/suburban.png',
                ),
                HostingResortItem(
                  onPressed: (){
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

  onPressed(String villa){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => ResortDescriptionScreen(
        villa,
      )),
    );
  }
}

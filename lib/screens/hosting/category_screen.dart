import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';

import '../../static_methods.dart';
import 'components/hosting_category_item.dart';

class CategoryScreen extends StatefulWidget {
  static String id = 'category_screen';
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.myAppBar('Category Screen', context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HostingCategoryItem(
                  onPressed: (){
                    onPressed(AccommodationType.villa);
                  },
                  size: size,
                  title: AccommodationType.villa,
                  assetName: 'assets/images/as.jpg',
                ),
                HostingCategoryItem(
                  onPressed: (){
                    onPressed(AccommodationType.hotel);
                  },
                  size: size,
                  title: AccommodationType.hotel,
                  assetName: 'assets/images/as.jpg',
                ),
                HostingCategoryItem(
                  onPressed: (){
                    onPressed(AccommodationType.suite);
                  },
                  size: size,
                  title: AccommodationType.suite,
                  assetName: 'assets/images/as.jpg',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HostingCategoryItem(
                  onPressed: (){
                    onPressed(AccommodationType.motel);
                  },
                  size: size,
                  title: AccommodationType.motel,
                  assetName: 'assets/images/as.jpg',
                ),
                HostingCategoryItem(
                  onPressed: (){
                    onPressed(AccommodationType.apartment);
                  },
                  size: size,
                  title: AccommodationType.apartment,
                  assetName: 'assets/images/as.jpg',
                ),
                HostingCategoryItem(
                  onPressed: (){
                    onPressed(AccommodationType.house);
                  },
                  size: size,
                  title: AccommodationType.house,
                  assetName: 'assets/images/as.jpg',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HostingCategoryItem(
                  onPressed: (){
                    onPressed(AccommodationType.cottage);
                  },
                  size: size,
                  title: AccommodationType.cottage,
                  assetName: 'assets/images/as.jpg',
                ),
                HostingCategoryItem(
                  onPressed: (){
                    onPressed(AccommodationType.residentialComplex);
                  },
                  size: size,
                  title: AccommodationType.residentialComplex,
                  assetName: 'assets/images/as.jpg',
                ),
                HostingCategoryItem(
                  onPressed: (){
                    onPressed(AccommodationType.hostel);
                  },
                  size: size,
                  title: AccommodationType.hostel,
                  assetName: 'assets/images/as.jpg',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HostingCategoryItem(
                  onPressed: (){
                    onPressed(AccommodationType.ecoTourism);
                  },
                  size: size,
                  title: AccommodationType.ecoTourism,
                  assetName: 'assets/images/as.jpg',
                ),
                HostingCategoryItem(
                  onPressed: (){
                    onPressed(AccommodationType.traditionalAccommodation);
                  },
                  size: size,
                  title: AccommodationType.traditionalAccommodation,
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
      MaterialPageRoute(builder: (context) => CategoryScreen(

      )),
    );
  }

}

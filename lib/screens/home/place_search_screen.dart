import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchSpaceScreen extends StatefulWidget {
  static String id = 'search_place_screen';

  @override
  _SearchSpaceScreenState createState() => _SearchSpaceScreenState();
}

class _SearchSpaceScreenState extends State<SearchSpaceScreen> {

  Size size;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SearchItem(
              size: size,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {

  final Size size;

  SearchItem({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(
                flex: 2,
              ),
              SizedBox(
                width: size.width - 80,
                child: Text(
                  'Dual Room apartment in Kish fajfl adfl jdsf ad jfl',
                  // textWidthBasis: TextWidthBasis.parent,
                  style: TextStyle(
                    // color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              Spacer(
                flex: 4,
              ),
              Text(
                'hormozgan, kish',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

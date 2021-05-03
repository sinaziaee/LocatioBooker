import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/screens/hosting/components/my_textfield.dart';
import 'components/search_item.dart';
import '../../models/search_model.dart';

class SearchSpaceScreen extends StatefulWidget {
  static String id = 'search_place_screen';

  @override
  _SearchSpaceScreenState createState() => _SearchSpaceScreenState();
}

class _SearchSpaceScreenState extends State<SearchSpaceScreen> {
  Size size;

  String url = '$mainUrl/api/villa/search/?number_of_villa=10';

  TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: PreferredSize(
        child: Container(
          margin: EdgeInsets.only(
            top: 40,
          ),
          color: Colors.lightBlue,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        cursorWidth: 1,
                        style: TextStyle(),
                        cursorColor: Colors.black,
                        decoration: InputDecoration.collapsed(
                          border: InputBorder.none,
                          hintText: 'Where are you going?',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: searchController.text.isNotEmpty,
                      child: IconButton(
                        color: Colors.grey,
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        preferredSize: Size(size.height, 80),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return SearchComponent(
                        size: size,
                        searchModel: SearchModel(
                          country: 'Iran',
                          state: 'Tehran',
                          city: 'Tehran',
                          name: 'Resort',
                          pricePerNight: 100,
                        ),
                        onPressed: () {
                          onPressed(SearchModel());
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressed(SearchModel searchModel) {
    print("pressed");
  }
}

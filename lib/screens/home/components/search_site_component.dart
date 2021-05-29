import 'package:flutter/material.dart';

class SiteComponent extends StatelessWidget {
  final String city;
  final int placesNum;
  final Function onTapped;
  final bool last;

  SiteComponent({
    this.city,
    this.placesNum,
    this.onTapped,
    this.last,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          child: ListTile(
            onTap: onTapped,
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 0.5,
                  color: Colors.grey,
                ),
              ),
              child: Icon(
                Icons.house,
                size: 45,
              ),
            ),
            title: Text(city ?? 'Accommodations in Kish'),
            subtitle: Text('${placesNum ?? 11} places'),
          ),
        ),
        SizedBox(
          height: 0,
        ),
        Visibility(
          visible: last,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            height: 0.5,
            color: Colors.grey,
            // width: size.width,
          ),
        ),
      ],
    );
  }
}

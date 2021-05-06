import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loctio_booker/models/villa.dart';

class aboutVilla extends StatefulWidget {
  final Villa villa;

  aboutVilla(this.villa);


  @override
  _aboutVillaState createState() => _aboutVillaState();
}

class _aboutVillaState extends State<aboutVilla> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100,),
            rooms(),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.green,
                  size: 30.0,
                ),

                Text("${widget.villa.ri} Villa with ${widget.villa.name} ")
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.green,
                  size: 30.0,
                ),

                Text("${widget.villa.ri} Villa with ${widget.villa.name} ")
              ],
            ),

          ],
        ),
      ),
    );
  }

   rooms() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      //clipBehavior: ,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.plus_one_sharp,
                color: Colors.green,
                size: 30.0,
              ),

              Text("This Villa has ${widget.villa.number_of_bedrooms} bedrooms " ,
                        style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.plus_one_sharp,
                color: Colors.green,
                size: 30.0,
              ),

              Text("This Villa has ${widget.villa.number_of_bathrooms} bathrooms ",
                style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w500
                ),)
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.plus_one_sharp,
                color: Colors.green,
                size: 30.0,
              ),

              Text("Villa with ${widget.villa.number_of_double_beds} double beds ",
                style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w500
                ),)
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.plus_one_sharp,
                color: Colors.green,
                size: 30.0,
              ),

              Text("Villa with ${widget.villa.number_of_single_beds} single beds ",
                style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w500
                ),)
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.plus_one_sharp,
                color: Colors.green,
                size: 30.0,
              ),

              Text("Villa with ${widget.villa.number_of_showers} showers ",
                style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w500
                ),)
            ],
          ),
        ],
      ),
    );

  }
}

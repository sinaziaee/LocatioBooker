import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/villa.dart';

class aboutVilla2 extends StatefulWidget {
  final Villa villa;

  aboutVilla2(this.villa);


  @override
  _aboutVillaState2 createState() => _aboutVillaState2();
}

class _aboutVillaState2 extends State<aboutVilla2> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: SingleChildScrollView(
        //scrollDirection: ,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 10,),
            //rooms(),
            SizedBox(
              height: 10,
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  Text(
                    "About" ,
                    style: kHeaderTextStyle,
                  ),
                ]
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.green,
                  size: 30.0,
                ),

                Text("${widget.villa.type} Villa with ${widget.villa.numberOfBedrooms} rooms" ,
                  style: kBodyTextStyle,
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.description,
                  color: Colors.green,
                  size: 30.0,
                ),

                Expanded(
                  child: Text("${widget.villa.description} " ,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: kBodyTextStyle,
                  ),
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),

            //Capacity

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Capacity",
                  style: kHeaderTextStyle,
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Icon(
                  Icons.home_repair_service,
                  color: Colors.green,
                  size: 30.0,
                ),

                Text("Normal : ${widget.villa.capacity}  Maximum : ${widget.villa.maxCapacity}" ,
                  style: kBodyTextStyle,
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),

            //Area

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Area",
                  style: kHeaderTextStyle,
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Icon(
                  Icons.home_outlined,
                  color: Colors.green,
                  size: 30.0,
                ),

                Text("${widget.villa.area} Meters " ,
                  style: kBodyTextStyle,
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),





            //villa Space

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Villa Space",
                  style: kHeaderTextStyle,
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Icon(
                  Icons.home,
                  color: Colors.green,
                  size: 30.0,
                ),

                Text("bedrooms :${widget.villa.numberOfBedrooms}  "
                    "bathrooms :${widget.villa.numberOfBathrooms}  "
                    "showers :${widget.villa.numberOfShowers} ",
                  style: kBodyTextStyle,
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),

            //Bed Sets
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Bed Sets",
                  style: kHeaderTextStyle,
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Icon(
                  Icons.home,
                  color: Colors.green,
                  size: 30.0,
                ),

                Text("Single Beds :${widget.villa.numberOfSingleBeds}  "
                    "Double Beds :${widget.villa.numberOfDoubleBeds}  ",
                  style: kBodyTextStyle,
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),

            //nothing

            ///*
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Villa Space",
                  style: kHeaderTextStyle,
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Icon(
                  Icons.home,
                  color: Colors.green,
                  size: 30.0,
                ),

                Text("bedrooms :${widget.villa.numberOfBedrooms}  "
                    "bathrooms :${widget.villa.numberOfBathrooms}  "
                    "showers :${widget.villa.numberOfShowers} ",
                  style: kBodyTextStyle,
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),
            //*/



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

              Text("This Villa has ${widget.villa.numberOfBedrooms} bedrooms " ,
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

              Text("This Villa has ${widget.villa.numberOfBathrooms} bathrooms ",
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

              Text("Villa with ${widget.villa.numberOfDoubleBeds} double beds ",
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

              Text("Villa with ${widget.villa.numberOfSingleBeds} single beds ",
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

              Text("Villa with ${widget.villa.numberOfShowers} showers ",
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

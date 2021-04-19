import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import '../../models/resort_description.dart';
import '../../static_methods.dart';
import 'components/bottom_container.dart';
import '04_facilitation_screen.dart';
import '../../models/resort_identification.dart';
import 'components/facilitate_item.dart';

class ResortIdentificationScreen extends StatefulWidget {
  final String villa;
  final User user;

  final ResortDescription resortDescription;

  ResortIdentificationScreen({this.villa, this.resortDescription, this.user});

  @override
  _ResortIdentificationScreenState createState() =>
      _ResortIdentificationScreenState();
}

class _ResortIdentificationScreenState
    extends State<ResortIdentificationScreen> {
  Size size;

  int bCapacity = 1,
      mCapacity = 1,
      numRoom = 1,
      numSingleBeds = 0,
      numDoubleBeds = 0,
      numBathroom = 0,
      numShowers = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.myAppBar('Resort Description Screen', context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
                top: size.width * 0.05,
              ),
              child: customContainer(),
            ),
            BottomContainer(
              text: 'Submit & Continue',
              onPressed: () {
                onPressed();
              },
            ),
          ],
        ),
      ),
    );
  }

  onPressed() {
    ResortIdentification resortIdentification = ResortIdentification(
      bCapacity: bCapacity,
      mCapacity: mCapacity,
      numDoubleBeds: numDoubleBeds,
      numRooms: numRoom,
      numSingleBeds: numSingleBeds,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FacilitationScreen(
          villa: widget.villa,
          resortDescription: widget.resortDescription,
          resortIdentification: resortIdentification,
          user: widget.user,
        ),
      ),
    );
  }

  Widget customContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Describe your accommodation space.',
          style: kBodyTextStyle.copyWith(),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        FacilitateItem(
          size: size,
          onIncrease: () {
            onIncreasePressed("bCapacity");
          },
          onDecrease: () {
            onDecreasePressed("bCapacity");
          },
          text: 'Base Capacity',
          count: bCapacity,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        FacilitateItem(
          size: size,
          onIncrease: () {
            onIncreasePressed("mCapacity");
          },
          onDecrease: () {
            onDecreasePressed("mCapacity");
          },
          text: 'Maximum capacity',
          count: mCapacity,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        FacilitateItem(
          size: size,
          onIncrease: () {
            onIncreasePressed("numRoom");
          },
          onDecrease: () {
            onDecreasePressed("numRoom");
          },
          text: 'Number of rooms',
          count: numRoom,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        FacilitateItem(
          size: size,
          onIncrease: () {
            onIncreasePressed("numSingleBeds");
          },
          onDecrease: () {
            onDecreasePressed("numSingleBeds");
          },
          text: 'Number of single beds',
          count: numSingleBeds,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        FacilitateItem(
          size: size,
          onIncrease: () {
            onIncreasePressed("numDoubleBeds");
          },
          onDecrease: () {
            onDecreasePressed("numDoubleBeds");
          },
          text: 'Number of Double beds',
          count: numDoubleBeds,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        FacilitateItem(
          size: size,
          onIncrease: () {
            onIncreasePressed("numBathroom");
          },
          onDecrease: () {
            onDecreasePressed("numBathroom");
          },
          text: 'Number of bathrooms',
          count: numBathroom,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        FacilitateItem(
          size: size,
          onIncrease: () {
            onIncreasePressed("numShowers");
          },
          onDecrease: () {
            onDecreasePressed("numShowers");
          },
          text: 'Number of showers',
          count: numShowers,
        ),
      ],
    );
  }

  onIncreasePressed(String which) {
    switch (which) {
      case "bCapacity":
        setState(() {
          (bCapacity >= 10) ? null : bCapacity++;
        });
        break;
      case "mCapacity":
        setState(() {
          (mCapacity >= 10) ? null : mCapacity++;
        });
        break;
      case "numRoom":
        setState(() {
          (numRoom >= 10) ? null : numRoom++;
        });
        break;
      case "numSingleBeds":
        setState(() {
          (numSingleBeds >= 10) ? null : numSingleBeds++;
        });
        break;
      case "numDoubleBeds":
        setState(() {
          (numDoubleBeds >= 10) ? null : numDoubleBeds++;
        });
        break;
      case "numShowers":
        setState(() {
          (numShowers >= 10) ? null : numShowers++;
        });
        break;
      case "numBathrooms":
        setState(() {
          (numBathroom >= 10) ? null : numBathroom++;
        });
        break;
    }
  }

  onDecreasePressed(String which) {
    switch (which) {
      case "bCapacity":
        setState(() {
          (bCapacity <= 1) ? null : bCapacity--;
        });
        break;
      case "mCapacity":
        setState(() {
          (mCapacity <= 1) ? null : mCapacity--;
        });
        break;
      case "numRoom":
        setState(() {
          (numRoom <= 1) ? null : numRoom--;
        });
        break;
      case "numSingleBeds":
        setState(() {
          (numSingleBeds <= 0) ? null : numSingleBeds--;
        });
        break;
      case "numDoubleBeds":
        setState(() {
          (numDoubleBeds <= 0) ? null : numDoubleBeds--;
        });
        break;
      case "numBathrooms":
        setState(() {
          (numBathroom <= 0) ? null : numBathroom--;
        });
        break;
      case "numShowers":
        setState(() {
          (numShowers <= 0) ? null : numShowers--;
        });
        break;
    }
  }
}

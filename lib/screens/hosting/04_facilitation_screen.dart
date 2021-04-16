import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/resort_description.dart';
import '../../static_methods.dart';
import '../../models/resort_identification.dart';
import 'components/bottom_container.dart';
import 'components/facilitate_item.dart';
import 'components/item.dart';

class FacilitationScreen extends StatefulWidget {
  final String villa;
  final ResortDescription resortDescription;
  final ResortIdentification resortIdentification;
  FacilitationScreen({this.villa, this.resortDescription, this.resortIdentification});

  @override
  _FacilitationScreenState createState() => _FacilitationScreenState();
}

class _FacilitationScreenState extends State<FacilitationScreen> {
  Size size;

  int bathroom = 1,
      iranianWc = 1,
      wc = 1;

  bool refrigerator,
      hairDryer,
      telephone,
      safeBox,
      kitchen,
      television,
      microwave,
      coffeeMaker,
      water,
      coach,
      dishWasher,
      washingMachine;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.myAppBar('Facilitation Screen', context),
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
      bCapacity: bathroom,
      mCapacity: iranianWc,
      numRooms: wc,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FacilitationScreen(
          villa: widget.villa,
          resortDescription: widget.resortDescription,
          resortIdentification: resortIdentification,
        ),
      ),
    );
  }

  Widget customContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What Facilitation your accommodation have?',
          style: kBodyTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        FacilitateItem(
          size: size,
          onIncrease: () {
            onIncreasePressed("bathroom");
          },
          onDecrease: () {
            onDecreasePressed("bathroom");
          },
          text: 'Bathroom',
          count: bathroom,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        FacilitateItem(
          size: size,
          onIncrease: () {
            onIncreasePressed("irWc");
          },
          onDecrease: () {
            onDecreasePressed("irWc");
          },
          text: 'iranian WC',
          count: iranianWc,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        FacilitateItem(
          size: size,
          onIncrease: () {
            onIncreasePressed("wc");
          },
          onDecrease: () {
            onDecreasePressed("wc");
          },
          text: 'WC',
          count: wc,
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Text(
          'Select other facilities of your accommodation.',
          style: kBodyTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        facilitationBody(),
      ],
    );
  }

  facilitationBody(){
    return Column(
      children: [
        Row(
          children: [
            Item(
              isSelected: false,
            ),
          ],
        ),
      ],
    );
  }

  onIncreasePressed(String which) {
    switch (which) {
      case "bathroom":
        setState(() {
          (bathroom >= 10) ? null : bathroom++;
        });
        break;
      case "wc":
        setState(() {
          (wc >= 10) ? null : wc++;
        });
        break;
      case "irWc":
        setState(() {
          (iranianWc >= 10) ? null : iranianWc++;
        });
        break;
    }
  }

  onDecreasePressed(String which) {
    switch (which) {
      case "bathroom":
        setState(() {
          (bathroom <= 1) ? null : bathroom--;
        });
        break;
      case "irWc":
        setState(() {
          (iranianWc <= 1) ? null : iranianWc--;
        });
        break;
      case "wc":
        setState(() {
          (wc <= 1) ? null : wc--;
        });
        break;
    }
  }

}

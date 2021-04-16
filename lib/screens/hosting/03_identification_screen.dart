import 'package:flutter/material.dart';
import '../../models/resort_description.dart';
import '../../static_methods.dart';
import 'components/bottom_container.dart';
import '04_facilitation_screen.dart';
import '../../models/resort_identification.dart';
import 'components/facilitate_item.dart';

class ResortIdentificationScreen extends StatefulWidget {
  final String villa;

  final ResortDescription resortDescription;

  ResortIdentificationScreen({this.villa, this.resortDescription});

  @override
  _ResortIdentificationScreenState createState() =>
      _ResortIdentificationScreenState();
}

class _ResortIdentificationScreenState
    extends State<ResortIdentificationScreen> {

  Size size;
  int capacity=0, numRoom=0, numSingleBeds=0, numDoubleBeds=0, numDoshaks=0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StaticMethods.myAppBar('Resort Description Screen', context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Expanded(
                child: customContainer(),
              ),
            ),
            BottomContainer(
              text: 'Submit & Continue',
              onPressed: () {
                // isValidated();
              },
            ),
          ],
        ),
      ),
    );
  }

  onPressed(ResortIdentification rd) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FacilitationScreen(
          villa: widget.villa,
          resortDescription: widget.resortDescription,
        ),
      ),
    );
  }

  Widget customContainer(){
    return Column(
      children: [
        Text('Describe your accommodation space.'),
        SizedBox(
          height: size.height * 0.05,
        ),
        FacilitateItem(
          onIncrease: onIncreasePressed(capacity),
          onDecrease: onDecreasePressed(capacity),
          text: 'text',
          count: capacity,
        ),
      ],
    );
  }

  onIncreasePressed(int count){
    setState(() {
      count++;
      print(count);
    });
  }

  onDecreasePressed(int count){
    setState(() {
      count--;
      print(count);
    });
  }

}

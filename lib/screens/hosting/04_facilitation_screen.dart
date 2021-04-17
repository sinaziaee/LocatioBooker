import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants.dart';
import '../../models/resort_description.dart';
import '../../static_methods.dart';
import '../../models/resort_identification.dart';
import 'components/bottom_container.dart';
import 'components/facilitate_item.dart';
import 'components/item.dart';
import '05_place_address_screen.dart';
import '../../models/facilitation.dart';

class FacilitationScreen extends StatefulWidget {
  final String villa;
  final ResortDescription resortDescription;
  final ResortIdentification resortIdentification;

  FacilitationScreen(
      {this.villa, this.resortDescription, this.resortIdentification});

  @override
  _FacilitationScreenState createState() => _FacilitationScreenState();
}

class _FacilitationScreenState extends State<FacilitationScreen> {
  Size size;

  bool hasRefrigerator = false,
      hasHairDryer = false,
      hasTelephone = false,
      hasSafeBox = false,
      hasKitchen = false,
      hasTelevision = false,
      hasMicrowave = false,
      hasCoffeeMaker = false,
      hasWater = false,
      hasWifi = false,
      hasChef = false,
      hasOven = false,
      hasFireplace = false,
      hasParking = false,
      hasPool = false,
      hasCoach = false,
      hasCooler = false,
      hasDishWasher = false,
      hasWashingMachine = false;

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
    Facilitation facilitations = Facilitation(
      hairDryer: hasHairDryer,
      furniture: hasCoach,
      coffeeMaker: hasCoffeeMaker,
      dishWasher: hasDishWasher,
      airConditioner: hasCooler,
      oven: hasKitchen,
      microwave: hasMicrowave,
      refrigerator: hasRefrigerator,
      safeBox: hasSafeBox,
      television: hasTelevision,
      telephone: hasTelephone,
      washingMachine: hasWashingMachine,
      hotWater: hasWater,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceAddressScreen(
          villa: widget.villa,
          resortDescription: widget.resortDescription,
          resortIdentification: widget.resortIdentification,
          facilitation: facilitations,
        ),
      ),
    );
  }

  Widget customContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

  facilitationBody() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Item(
              text: 'Refrigerator',
              onTapped: () {
                setState(() {
                  hasRefrigerator = !hasRefrigerator;
                });
              },
              isSelected: hasRefrigerator,
              size: size,
              asset: 'assets/images/facilitation/i-fridge.png',
            ),
            Item(
              text: 'Air-conditioner',
              onTapped: () {
                setState(() {
                  hasCooler = !hasCooler;
                });
              },
              isSelected: hasCooler,
              size: size,
              asset: 'assets/images/facilitation/i-fan.png',
            ),
            Item(
              text: 'Hair dryer',
              onTapped: () {
                setState(() {
                  hasHairDryer = !hasHairDryer;
                });
              },
              isSelected: hasHairDryer,
              size: size,
              asset: 'assets/images/facilitation/i-hair-dryer.png',
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Item(
              text: 'Telephone',
              onTapped: () {
                setState(() {
                  hasTelephone = !hasTelephone;
                });
              },
              isSelected: hasTelephone,
              size: size,
              asset: 'assets/images/facilitation/i-telephone.png',
            ),
            Item(
              text: 'Safe',
              onTapped: () {
                setState(() {
                  hasSafeBox = !hasSafeBox;
                });
              },
              isSelected: hasSafeBox,
              size: size,
              asset: 'assets/images/facilitation/i-safe-box.png',
            ),
            Item(
              text: 'Kitchen',
              onTapped: () {
                setState(() {
                  hasKitchen = !hasKitchen;
                });
              },
              isSelected: hasKitchen,
              size: size,
              asset: 'assets/images/facilitation/i-kitchen.png',
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Item(
              text: 'TV',
              onTapped: () {
                setState(() {
                  hasTelevision = !hasTelevision;
                });
              },
              isSelected: hasTelevision,
              size: size,
              asset: 'assets/images/facilitation/i-tv.png',
            ),
            Item(
              text: 'Furniture',
              onTapped: () {
                setState(() {
                  hasCoach = !hasCoach;
                });
              },
              isSelected: hasCoach,
              size: size,
              asset: 'assets/images/facilitation/i-sofa.png',
            ),
            Item(
              text: 'Microwave',
              onTapped: () {
                setState(() {
                  hasMicrowave = !hasMicrowave;
                });
              },
              isSelected: hasMicrowave,
              size: size,
              asset: 'assets/images/facilitation/i-microwave.png',
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Item(
              text: 'Dish Washer',
              onTapped: () {
                setState(() {
                  hasDishWasher = !hasDishWasher;
                });
              },
              isSelected: hasDishWasher,
              size: size,
              asset: 'assets/images/facilitation/i-dish-washer.png',
            ),
            Item(
              text: 'Washing Machine',
              onTapped: () {
                setState(() {
                  hasWashingMachine = !hasWashingMachine;
                });
              },
              isSelected: hasWashingMachine,
              size: size,
              asset: 'assets/images/facilitation/i-washing-machine.png',
            ),
            Item(
              text: 'Coffee Maker',
              onTapped: () {
                setState(() {
                  hasCoffeeMaker = !hasCoffeeMaker;
                });
              },
              isSelected: hasCoffeeMaker,
              size: size,
              asset: 'assets/images/facilitation/i-coffee-maker.png',
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Item(
              text: 'Cooking basics',
              onTapped: () {
                setState(() {
                  hasChef = !hasChef;
                });
              },
              isSelected: hasChef,
              size: size,
              asset: 'assets/images/facilitation/i-chef.png',
            ),
            Item(
              text: 'Oven',
              onTapped: () {
                setState(() {
                  hasOven = !hasOven;
                });
              },
              isSelected: hasOven,
              size: size,
              asset: 'assets/images/facilitation/i-cooker.png',
            ),
            Item(
              text: 'Fire place',
              onTapped: () {
                setState(() {
                  hasFireplace = !hasFireplace;
                });
              },
              isSelected: hasFireplace,
              size: size,
              asset: 'assets/images/facilitation/i-fireplace.png',
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Item(
              text: 'Pool',
              onTapped: () {
                setState(() {
                  hasPool = !hasPool;
                });
              },
              isSelected: hasPool,
              size: size,
              asset: 'assets/images/facilitation/i-pool.png',
            ),
            Item(
              text: 'Parking',
              onTapped: () {
                setState(() {
                  hasParking = !hasParking;
                });
              },
              isSelected: hasParking,
              size: size,
              asset: 'assets/images/facilitation/i-parking.png',
            ),
            Item(
              text: 'Wifi',
              onTapped: () {
                setState(() {
                  hasWifi = !hasWifi;
                });
              },
              isSelected: hasWifi,
              size: size,
              asset: 'assets/images/facilitation/i-wifi.png',
            ),
          ],
        ),
      ],
    );
  }

}

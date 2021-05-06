import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'components/my_textfield.dart';
import '../../static_methods.dart';
import 'components/bottom_container.dart';
import '../../models/resort_description.dart';
import '03_identification_screen.dart';

class ResortDescriptionScreen extends StatefulWidget {
  final String resortType;
  final User user;
  final Key key = Key('resort_description_screen_key');

  ResortDescriptionScreen(this.resortType, this.user);

  @override
  _ResortDescriptionScreenState createState() =>
      _ResortDescriptionScreenState();
}

class _ResortDescriptionScreenState extends State<ResortDescriptionScreen> {
  Size size;
  FocusNode node;
  TextEditingController nameController,
      descriptionController,
      priceController,
      areaController,
      costController;

  @override
  void initState() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    areaController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    node = FocusScope.of(context);

    return Scaffold(
      appBar: StaticMethods.myAppBar('Resort Description Screen', context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: customContainer(),
            ),
            BottomContainer(
              text: 'Submit & Continue',
              onPressed: () {
                isValidated();
              },
              key: Key('resort_description_submit'),
            ),
          ],
        ),
      ),
    );
  }

  isValidated() {
    String name = nameController.text;
    String description = descriptionController.text;
    String price = priceController.text;
    String area = areaController.text;

    // assert(nameController.text.isNotEmpty);
    // assert(descriptionController.text.isNotEmpty);
    // // assert(priceController.text.isNotEmpty);
    // assert(areaController.text.isNotEmpty);

    if (name.length == 0) {
      // throw AssertionError('specify a name');
      // assert(nameController.text.isEmpty);
      StaticMethods.showErrorDialog(context, 'Enter a name for your place');
      return;
    }
    if (price.length == 0) {
      StaticMethods.showErrorDialog(
          context, 'Enter Price per day of your place');
      return;
    }
    if (area.length == 0) {
      StaticMethods.showErrorDialog(
          context, 'Enter area in meters for your place');
      return;
    }
    ResortDescription rd = ResortDescription(
      name: name,
      about: description,
      price: int.parse(price),
      area: int.parse(area),
    );
    onPressed(rd);
  }

  onPressed(ResortDescription rd) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResortIdentificationScreen(
          villa: widget.resortType,
          resortDescription: rd,
          user: widget.user,
        ),
      ),
    );
  }

  Widget customContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(
          'Describe your place and record its information.',
          style: kHeaderTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            // fontSize: size.width * 0.045,
          ),
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        Text(
          'Place Name',
          style: kHeaderTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            // fontSize: size.width * 0.04,
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          'Use short words and appropriate about your place to choose a name.',
          style: kHeaderTextStyle.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 14,
            // fontSize: size.width * 0.032,
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        MyTextField(
          key: Key('resort_name'),
          size: size,
          controller: nameController,
          isLast: false,
          node: node,
          isPassword: false,
          inputType: TextInputType.text,
          hint: 'Ex: Coastal ecoTourism cottage',
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Row(
          children: [
            Text(
              'About place',
              style: kHeaderTextStyle.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                // fontSize: size.width * 0.04,
              ),
            ),
            Text(
              '(optional)',
              style: kHeaderTextStyle.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.grey[600],
                // fontSize: size.width * 0.04,
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          'Write about features, sightseeing and anything that makes your place spectacular and unique compared to the others. ',
          style: kHeaderTextStyle.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 14,
            // fontSize: size.width * 0.032,
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        MyTextField(
          key: Key('resort_description'),
          lines: 4,
          height: 120,
          size: size,
          controller: descriptionController,
          isLast: false,
          node: node,
          isPassword: false,
          inputType: TextInputType.text,
          hint: 'Ex: Kashan traditional residence in the center',
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          'Price (\$)',
          style: kHeaderTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            // fontSize: size.width * 0.04,
          ),
        ),
        Text(
          'Enter the price per day in dollars',
          style: kHeaderTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.red,
            // fontSize: size.width * 0.04,
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        MyTextField(
          key: Key('resort_price'),
          lines: 1,
          size: size,
          controller: priceController,
          isLast: false,
          node: node,
          isPassword: false,
          inputType: TextInputType.number,
          hint: 'Ex: 50\$',
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          'Area (meters)',
          style: kHeaderTextStyle.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            // fontSize: size.width * 0.04,
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        MyTextField(
          key: Key('resort_area'),
          lines: 1,
          size: size,
          controller: areaController,
          isLast: true,
          node: node,
          isPassword: false,
          inputType: TextInputType.number,
          hint: 'Ex: 95',
        ),
      ],
    );
  }
}

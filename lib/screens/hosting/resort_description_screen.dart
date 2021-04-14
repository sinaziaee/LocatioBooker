import 'package:flutter/material.dart';
import 'package:loctio_booker/constants.dart';
import 'components/my_textfield.dart';
import '../../static_methods.dart';

class ResortDescriptionScreen extends StatefulWidget {
  @override
  _ResortDescriptionScreenState createState() =>
      _ResortDescriptionScreenState();
}

class _ResortDescriptionScreenState extends State<ResortDescriptionScreen> {
  Size size;
  FocusNode node;
  TextEditingController nameController,
      descriptionController,
      infrastructureAreaController,
      totalBuildingAreaController,
      costController;

  @override
  void initState() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    infrastructureAreaController = TextEditingController();
    totalBuildingAreaController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    infrastructureAreaController.dispose();
    totalBuildingAreaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    node = FocusScope.of(context);

    return Scaffold(
      appBar: StaticMethods.myAppBar('Resort Description Screen', context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Describe your accommodation and record its information.',
                style: kHeaderTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.045,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                'Name of accommodation',
                style: kHeaderTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.04,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'Use short words and appropriate about your accommodation to choose a name.',
                style: kHeaderTextStyle.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: size.width * 0.032,
                ),
              ),
              MyTextField(
                size: size,
                controller: nameController,
                isLast: false,
                hint: 'Exp: Coastal ecoTourism cottage',
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                'About accommodation',
                style: kHeaderTextStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.04,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

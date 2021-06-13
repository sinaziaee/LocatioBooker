import 'package:flutter/material.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/hosting/06_map_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:opencage_geocoder/opencage_geocoder.dart';
import '../../constants.dart';
import '../../models/resort_description.dart';
import '../../static_methods.dart';
import '../../models/resort_identification.dart';
import '../../models/facilitation.dart';
import 'components/bottom_container.dart';
import 'components/country_state_city_picker.dart';
import 'components/my_textfield.dart';
import '08_gallery_screen.dart';
import "package:latlong2/latlong.dart" as latLng;
import '../../models/place_address.dart';

class PlaceAddressScreen extends StatefulWidget {
  final String villa;
  final ResortDescription resortDescription;
  final ResortIdentification resortIdentification;
  final Facilitation facilitation;
  final Key key = Key('resort_place_address_screen_key');
  final User user;

  PlaceAddressScreen(
      {this.villa,
      this.user,
      this.resortDescription,
      this.resortIdentification,
      this.facilitation});

  @override
  _PlaceAddressScreenState createState() => _PlaceAddressScreenState();
}

class _PlaceAddressScreenState extends State<PlaceAddressScreen> {
  Size size;
  FocusNode node;
  String countryValue = '', stateValue = '', cityValue = '';
  TextEditingController postalCodeController, addressController;
  bool showSpinner = false;

  @override
  void initState() {
    postalCodeController = TextEditingController();
    addressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    node = FocusScope.of(context);
    return Scaffold(
      appBar: StaticMethods.myAppBar('Location Screen', context, widget.user),
      body: ModalProgressHUD(
        progressIndicator: kMyProgressIndicator,
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                key: Key('submit_place_address'),
                text: 'Submit & Continue',
                onPressed: () {
                  isValid();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter your place address details here.',
          style: kHeaderTextStyle.copyWith(),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          'This information is only for better accessibility of your guests and would be shown only after reservations.',
          style: kBodyTextStyle.copyWith(
            fontSize: 14,
            color: Colors.blueGrey[600],
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        CountryCityPicker(
          onCityChanged: (value) {
            setState(() {
              cityValue = value;
            });
            print(cityValue);
          },
          onStateChanged: (value) {
            setState(() {
              stateValue = value;
            });
          },
          onCountryChanged: (value) {
            setState(() {
              countryValue = value;
            });
          },
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Text(
          'Address',
          style: kBodyTextStyle.copyWith(),
        ),
        Text(
          'Write your full address including City, state, Street, Alley and ...',
          style: kBodyTextStyle.copyWith(
            color: Colors.blueGrey,
            fontSize: 13,
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        MyTextField(
          size: size,
          inputType: TextInputType.streetAddress,
          height: size.height * 0.11,
          lines: 3,
          hint: 'Ex: MalekAbad Ave-Farhad Street-Farhad 17',
          controller: addressController,
          node: node,
          isLast: false,
          isPassword: false,
          key: Key('place_text_field'),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          children: [
            Text(
              'Postal Code',
              style: kBodyTextStyle.copyWith(),
            ),
            Text(
              ' (Optional)',
              style: kBodyTextStyle.copyWith(
                fontSize: 15,
                color: Colors.blueGrey[600],
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        MyTextField(
          size: size,
          lines: 1,
          inputType: TextInputType.number,
          controller: postalCodeController,
          node: node,
          hint: 'Ex: 1234567890',
          isLast: true,
          isPassword: false,
          key: Key('postal_code_text_field'),
        ),
      ],
    );
  }

  isValid() {
    String postalCode = postalCodeController.text;
    String address = addressController.text;

    if (countryValue.length == 0) {
      return StaticMethods.showErrorDialog(context, 'Select a country');
    }
    if (stateValue.length == 0) {
      return StaticMethods.showErrorDialog(context, 'Select a state');
    }
    if (cityValue.length == 0) {
      return StaticMethods.showErrorDialog(context, 'Select a city');
    }
    if (address.length == 0) {
      return StaticMethods.showErrorDialog(context, 'Enter an address');
    }
    if (postalCode.length != 0 && postalCode.length != 10) {
      return StaticMethods.showErrorDialog(
          context, 'Enter a correct format of postal code');
    }

    onPressed(postalCode, address);
  }

  onPressed(String postalCode, String address) async{
    int pCode;
    if (postalCode.length != 0) {
      pCode = int.parse(postalCode);
    }

    PlaceAddress placeAddress = PlaceAddress(
      postalCode: pCode,
      address: address,
      country: countryValue.replaceAll(' Province', ''),
      state: stateValue,
      city: cityValue,
    );

    // todo: check null safety
    var coordinates = await getLocation();
    if(coordinates == null){
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          villa: widget.villa,
          resortDescription: widget.resortDescription,
          resortIdentification: widget.resortIdentification,
          facilitation: widget.facilitation,
          placeAddress: placeAddress,
          user: widget.user,
          location: latLng.LatLng(coordinates.latitude, coordinates.longitude),
        ),
      ),
    );
  }

  Future<Coordinates> getLocation() async{
    setState(() {
      showSpinner = true;
    });
    Coordinates response = await StaticMethods.getLocation(context, cityValue, stateValue, countryValue);
    print(response);
    setState(() {
      showSpinner = true;
    });
    return response;
  }

}

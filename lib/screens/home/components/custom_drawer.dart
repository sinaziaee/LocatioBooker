import 'package:flutter/material.dart';
import 'package:loctio_booker/screens/hosting/components/country_state_city_picker.dart';

class CustomDrawer extends StatelessWidget {
  String cityValue, stateValue, countryValue;
  final Function(String) onCountryChanged;
  final Function(String) onStateChanged;
  final Function(String) onCityChanged;

  CustomDrawer({
    @required this.stateValue,
    @required this.cityValue,
    @required this.countryValue,
    @required this.onCountryChanged,
    @required this.onStateChanged,
    @required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    print(this.countryValue);
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CountryCityPicker(
                onCityChanged: onCityChanged,
                onStateChanged: onStateChanged,
                onCountryChanged: onCountryChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

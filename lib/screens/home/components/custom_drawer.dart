import 'package:flutter/material.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/home/date_picker_screen.dart';
import 'package:loctio_booker/screens/hosting/components/country_state_city_picker.dart';

class CustomDrawer extends StatelessWidget {
  String cityValue, stateValue, countryValue;
  final Function(String) onCountryChanged;
  final Function(String) onStateChanged;
  final Function(String) onCityChanged;
  final User user;

  CustomDrawer({
    @required this.stateValue,
    @required this.cityValue,
    @required this.countryValue,
    @required this.onCountryChanged,
    @required this.onStateChanged,
    @required this.onCityChanged,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DatePickerScreen(
                      user: user,
                    );
                  },
                ),
              );
            },
            child: Text('Date Picker'),
          ),
        ],
      ),
    );
  }
}

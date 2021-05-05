import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

class CountryCityPicker extends StatelessWidget {
  final Function(String) onCountryChanged;
  final Function(String) onStateChanged;
  final Function(String) onCityChanged;

  CountryCityPicker(
      {this.onCityChanged, this.onCountryChanged, this.onStateChanged});

  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      showStates: true,
      showCities: true,
      flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      layout: Layout.vertical,
      disabledDropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.grey.shade300,
          border: Border.all(color: Colors.grey.shade300, width: 1)),
      selectedItemStyle: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      dropdownHeadingStyle: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      dropdownItemStyle: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      dropdownDialogRadius: 10.0,
      searchBarRadius: 10.0,
      onCountryChanged: onCountryChanged,
      onStateChanged: onStateChanged,
      onCityChanged: onCityChanged,
    );
  }
}

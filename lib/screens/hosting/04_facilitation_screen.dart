import 'package:flutter/material.dart';
import '../../models/resort_description.dart';
import '../../static_methods.dart';

class FacilitationScreen extends StatefulWidget {
  final String villa;

  final ResortDescription resortDescription;

  FacilitationScreen({this.villa, this.resortDescription});

  @override
  _FacilitationScreenState createState() => _FacilitationScreenState();
}

class _FacilitationScreenState extends State<FacilitationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StaticMethods.myAppBar('Facilitation Screen', context),
    );
  }
}

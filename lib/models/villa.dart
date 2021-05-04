

import 'package:loctio_booker/models/resort_identification.dart';

class villa{
    final String country;
    final String state;
    final String city;

    final String address;
    final String postalCode;

    final String name;
    final String type;
    final String description;
    final int price;
    final String images;
    final String facilities;

    //final String address;

    final int latitude;
    final int longitude;
    final int area;

    final ResortIdentification ri;

  villa(this.country, this.state,
      this.city, this.address,
      this.postalCode, this.name,
      this.type, this.description,
      this.price, this.images,
      this.facilities, this.latitude,
      this.longitude, this.area, this.ri);

}
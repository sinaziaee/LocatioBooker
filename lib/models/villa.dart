import 'package:loctio_booker/models/resort_identification.dart';

class Villa {
  final int id;
  final String country;
  final String state;
  final String city;
  final String address;
  final String postalCode;
  final String name;
  final String type;
  final String description;
  final int price;
  final String owner;
  final List<String> images;
  final List<String> facilities;
  final double latitude;
  final double longitude;
  final int capacity;
  final int maxCapacity;
  final int numberOfBathrooms;
  final int numberOfBedrooms;
  final int numberOfSingleBeds;
  final int numberOfDoubleBeds;
  final double rate;
  final int numberOfShowers;
  final int area, ownerId;
  final List rules;
  final ResortIdentification ri;
  final bool isFavorite, isVisible, isReserved;

  Villa({
    this.capacity,
    this.isFavorite,
    this.rate,
    this.maxCapacity,
    this.numberOfBathrooms,
    this.numberOfBedrooms,
    this.numberOfSingleBeds,
    this.numberOfDoubleBeds,
    this.numberOfShowers,
    this.id,
    this.country,
    this.state,
    this.city,
    this.address,
    this.postalCode,
    this.name,
    this.owner,
    this.type,
    this.description,
    this.price,
    this.images,
    this.facilities,
    this.latitude,
    this.longitude,
    this.area,
    this.ownerId,
    this.ri,
    this.rules,
    this.isVisible,
    this.isReserved,
  });

  factory Villa.fromJson(Map<String, dynamic> json) {
    print(json);
    List<String> imagesList = [];
    List<String> facilitiesList = [];
    print('here');

    for (var item in json['images']) {
      imagesList.add(item);
    }

    for (var item in json['facilities']) {
      facilitiesList.add(item);
    }

    print('here2');
    return Villa(
        id: json['villa_id'],
        isFavorite: json['like'],
        numberOfBathrooms: json['number_of_bathrooms'],
        numberOfBedrooms: json['number_of_bedrooms'],
        numberOfDoubleBeds: json['number_of_double_beds'],
        numberOfSingleBeds: json['number_of_single_beds'],
        numberOfShowers: json['number_of_showers'],
        capacity: json['capacity'],
        maxCapacity: json['max_capacity'],
        owner: json['owner'],
        country: json['country'],
        state: json['state'],
        city: json['city'],
        ownerId: json['owner_id'],
        address: json['address'],
        postalCode: json['postal_code'],
        name: json['name'],
        type: json['type'],
        description: json['description'],
        price: json['price_per_night'],
        images: imagesList,
        facilities: facilitiesList,
        latitude: json['latitude'],
        longitude: json['longitude'],
        area: json['area'],
        rules: json['rules'],
        rate: json['rate'],
        isReserved: json['reserved'],
        isVisible: json['visible'],
        ri: json['ri']);
  }

}

import 'package:loctio_booker/models/resort_identification.dart';

class Villa{
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
  final int number_of_bathrooms;
  final int number_of_bedrooms;
  final int number_of_single_beds;
  final int number_of_double_beds;
  final int number_of_showers;
  final int area;
  final ResortIdentification ri;

  ///*
  Villa({this.capacity, this.maxCapacity, this.number_of_bathrooms,
    this.number_of_bedrooms, this.number_of_single_beds,
    this.number_of_double_beds, this.number_of_showers, this.id , this.country, this.state,
    this.city, this.address,
    this.postalCode,  this.name,this.owner ,
    this.type, this.description,
    this.price,  this.images,
    this.facilities,  this.latitude,
    this.longitude,  this.area,  this.ri});//*/

  factory Villa.fromJson(Map<String, dynamic> json){
    List<String> imagesList = [];
    List<String> facilitiesList = [];


    for(var item in json['images']){
      //print("item : ${item}");
      imagesList.add(item);
    }

    for(var item in json['facilities']){
      facilitiesList.add(item);
    }
    return Villa(
        id: json['villa_id'],
        number_of_bathrooms : json['number_of_bathrooms'],
        number_of_bedrooms : json['number_of_bedrooms'],
        number_of_double_beds : json['number_of_double_beds'],
        number_of_single_beds: json['number_of_single_beds'],
        number_of_showers: json['number_of_showers'],

        capacity: json['capacity'],
        maxCapacity: json['max_capacity'],


        country : json['country'],
        state : json['state'],
        city: json['city'],
        address : json['address'],
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
        ri: json['ri']);

  }

}
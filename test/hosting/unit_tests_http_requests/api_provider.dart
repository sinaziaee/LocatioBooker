import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:loctio_booker/models/facilitation.dart';
import 'package:loctio_booker/models/place_address.dart';
import 'package:loctio_booker/models/resort_description.dart';
import 'package:loctio_booker/models/resort_identification.dart';
import 'dart:convert';

import 'item_model.dart';

class ApiProvider {
  Client client = Client();

  fetchPosts() async {
    final response = await client
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));
    // ItemModel itemModel = ItemModel.fromJson(json.decode(response.body));
    return null;
  }

  checkIdentityDocument() async {
    final response = await client.get(
      Uri.parse(
          "https://softcheetahs.herokuapp.com/api/account/check-document-existence"),
      headers: {
        HttpHeaders.authorizationHeader: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b',
      },
    );
    Doc item = Doc.fromJson(json.decode(response.body));
    return item;
  }

  uploadGalleryImages(File file) async {
    final response = await client.post(
        Uri.parse(
            "https://softcheetahs.herokuapp.com/api/villa/user/images/"),
        headers: {
          HttpHeaders.authorizationHeader: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b',
        },
        body:{
          'file': file.toString(),
        }
    );
    Gallery item = Gallery.fromJson(json.decode(response.body));
    return item;
  }

  uploadInfo(String villa, PlaceAddress placeAddress, ResortDescription resortDescription, ResortIdentification resortIdentification, Facilitation facilitation, File file) async {
    Map map = Map();
    map['type'] = villa;
    map['country'] = placeAddress.country;
    map['state'] = placeAddress.state;
    map['city'] = placeAddress.city;
    map['postal_code'] = placeAddress.postalCode.toString();
    map['name'] = resortDescription.name;
    map['description'] = resortDescription.about;
    map['area'] = resortDescription.area;
    map['price_per_night'] = resortDescription.price;
    map['address'] = placeAddress.address;
    map['latitude'] = 0.0;
    map['longitude'] = 0.0;
    map['capacity'] = resortIdentification.bCapacity;
    map['max_capacity'] = resortIdentification.mCapacity;
    map['number_of_bathrooms'] = resortIdentification.numBathrooms;
    map['number_of_showers'] = resortIdentification.numShowers;
    map['number_of_single_beds'] = resortIdentification.numSingleBeds;
    map['number_of_double_beds'] = resortIdentification.numDoubleBeds;
    map['number_of_bedrooms'] = resortIdentification.numRooms;
    map['image_id_list'] = [1, 2, 3];
    map['facilities_list'] = facilitation.getItemsList();
    map["doc_id_list"] = [1, 2];
    final response = await client.post(
        Uri.parse(
            "https://softcheetahs.herokuapp.com/api/account/upload-documents"),
        headers: {
          HttpHeaders.authorizationHeader: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b',
        },
        body:{
          'file': file.toString(),
        }
    );
    Info item = Info.fromJson(json.decode(response.body));
    return item;
  }

}

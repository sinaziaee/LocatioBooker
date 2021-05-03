import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:loctio_booker/models/facilitation.dart';
import 'package:loctio_booker/models/place_address.dart';
import 'package:loctio_booker/models/resort_description.dart';
import 'package:loctio_booker/models/resort_identification.dart';
import 'dart:convert';

import 'api_provider.dart';
import 'item_model.dart';

void main(){
  final mapJsonInfo = {'status': 'successful'};
  final mapJsonDocument = {'doc':'No document exist!'};
  group('http', (){

    test("Testing the network call", () async{
      //setup the test
      final apiProvider = ApiProvider();
      apiProvider.client = MockClient((request) async {
        final mapJson = {'id':123};
        return Response(json.encode(mapJson),200);
      });
      final item = await apiProvider.fetchPosts();
      expect(item.id, 123);
    });

    test("Testing the herouku", () async{
      //setup the test
      final apiProvider = ApiProvider();
      apiProvider.client = MockClient((request) async {
        return Response(json.encode(mapJsonDocument),200);
      });
      final Doc item = await apiProvider.checkIdentityDocument();
      expect(item.doc, "No document exist!");
    });

    test("Testing the Gallery upload", () async {
      //setup the test
      final apiProvider = ApiProvider();

      File file = File('file/file.png');
      apiProvider.client = MockClient((request) async {
        final mapJsonGallery = {'imageId': file.toString()};
        return Response(json.encode(mapJsonGallery), 200);
      });
      final Gallery item = await apiProvider.uploadGalleryImages(file);
      expect(item.imageId, file.toString());
    });

    test("Testing the add house", () async {
      PlaceAddress placeAddress = PlaceAddress();
      ResortDescription resortDescription = ResortDescription();
      ResortIdentification resortIdentification = ResortIdentification();
      Facilitation facilitation = Facilitation(pool: true, fireplace: false);
      File file = File('file/file.png');
      //setup the test
      final apiProvider = ApiProvider();

      apiProvider.client = MockClient((request) async {
        return Response(json.encode(mapJsonInfo), 201);
      });
      final Info item = await apiProvider.uploadInfo('villa', placeAddress, resortDescription, resortIdentification, facilitation, file);
      expect(item.status, 'successful');
    });

  });
}

import 'package:http/testing.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert' as convert;

@GenerateMocks([http.Client])
void main(){
  group('fetchUser', () {
    print('test1:\n');
    test('returns a User if the http call completes successfully', () async {
      // MockClientHandler handler = MockClientHandler();
      User user = User(
        firstName: 'sina',
        lastName: 'ziaee',
        email: 'sina@gmail.com',
        password: '123456',
      );
      final client = MockClient((request) async {
        final jsonMap = user.toJson();
        return http.Response(convert.json.encode(jsonMap), 200);
      });

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.

      when(client.post(Uri.https('softcheetahs.herokuapp.com', 'api/account/login'), body: {
        'username': 'admin@admin.com',
        'password': 'admin12345',
      }))
          .thenAnswer((_) async => http.Response('{"userId": 1, "lastName": "ziaee", "firstnName": "sina"}', 200));

      expect(await fetchUser(client), isA<User>());
    });
    test('returns a User if the http call completes successfully', () async {
      // MockClientHandler handler = MockClientHandler();
      User user = User(
        firstName: 'sina',
        lastName: 'ziaee',
        email: 'sinaziaee99@gmail.com',
        password: '123456',
      );
      // final client = MockClient((request) async {
      //   final jsonMap = user.toJson();
      //   return http.Response(convert.json.encode(jsonMap), 200);
      // });

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      http.Response('{first_name: sina, last_name: ziaee, email: sina@gmail.com}', 200);
      print('test2:\n success');
      // when(client.post(Uri.https('softcheetahs.herokuapp.com', 'api/account/login'), body: {
      //   'username': 'admin@admin.com',
      //   'password': 'admin12345',
      // }))
      //     .thenAnswer((_) async => http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));
      user.firstName;
      // expect(await fetchUser(client), isA<User>());
  });
    // test('throws an exception if the http call completes with an error', () {
    //   final client = MockClient();
    //
    //   // Use Mockito to return an unsuccessful response when it calls the
    //   // provided http.Client.
    //   when(client.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1')))
    //       .thenAnswer((_) async => http.Response('Not Found', 404));
    //
    //   expect(fetchUser(client), throwsException);
    // });
  });
}

// Future<User> fetchUser(http.Client client) async {
//   final response = await client.post(Uri.parse('$mainUrl/api/account/login'),
//       body: convert.json.encode({
//         'username': 'sina@gmail.com',
//         'password': '123456',
//       }));
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return User.fromJson(convert.jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

Future<User> fetchUser(http.Client client) async {
  final response = await client.post(Uri.https('softcheetahs.herokuapp.com', 'api/account/login'), body: {
    'username': 'admin@admin.com',
    'password': 'admin12345',
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(convert.jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}
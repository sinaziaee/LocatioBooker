// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/testing.dart';
// import 'package:loctio_booker/models/user.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// // Generate a MockClient using the Mockito package.
// // Create new instances of this class in each test.
// @GenerateMocks([http.Client])
// void main() {
//   group('fetchAlbum', () {
//     test('returns an Album if the http call completes successfully', () async {
//       final client = MockClient();
//
//       // Use Mockito to return a successful response when it calls the
//       // provided http.Client.
//       when(client.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1')))
//           .thenAnswer((_) async => http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));
//
//       expect(await fetchUser(client), isA<User>());
//     });
//
//     test('throws an exception if the http call completes with an error', () {
//       final client = MockClient();
//
//       // Use Mockito to return an unsuccessful response when it calls the
//       // provided http.Client.
//       when(client.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1')))
//           .thenAnswer((_) async => http.Response('Not Found', 404));
//
//       expect(fetchUser(client), throwsException);
//     });
//   });
// }
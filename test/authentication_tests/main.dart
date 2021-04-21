// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
// import 'package:loctio_booker/constants.dart';
// import 'package:loctio_booker/models/user.dart';
//
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
//     return User.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }
//
// class Album {
//   final int userId;
//   final int id;
//   final String title;
//
//   Album({@required this.userId, @required this.id, @required this.title});
//
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   // MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   Future<User> user;
//
//   @override
//   void initState() {
//     super.initState();
//     user = fetchUser(http.Client());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<User>(
//             future: user,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data.firstName);
//               } else if (snapshot.hasError) {
//                 return Text("${snapshot.error}");
//               }
//
//               // By default, show a loading spinner.
//               return CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loctio_booker/main.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/hosting/00_hosing_screen.dart';
import 'package:loctio_booker/screens/hosting/01_resort_type_screen.dart';
//import 'package:test/test.dart';
import '00_hosting_screen_2.dart';


void main() {
  User myUser = User(
      firstName: 'Ahmad' ,
      bio: "Finally life becomes sweet",
      country: 'Russia' ,
      email: 'AhmadNorollahi@gmail.com',
      filename: 'A' ,
      nationalCode: '9393939',
      gender: 'Male',
      image: 'Alli',
      lastName: 'Razavi',
      password: '191919191',
      phone: '09197373737',
      token: 'Token 02929292992'
  );

  testWidgets('Testing Resort Type Screen !!', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(home: ResortTypeScreen(myUser))
    );

    // Create the Finders.
    final titleFinder = find.text('Resort Type Screen');

    final urban = find.text('Urban');
    final textCounter = find.byType(Text );
    final imageCounter = find.byType(Image);
    final iconCounter = find.byType(Icon);

    expect(titleFinder , findsOneWidget);
    expect(textCounter, findsNWidgets(10));

    //await expectLater(find.byType(ResortTypeScreen), matchesGoldenFile('../assets/images/category/motel.png'));
    expect(urban, findsOneWidget );
    expect(imageCounter, findsNWidgets(8));
    expect(iconCounter, findsNWidgets(1));

  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loctio_booker/screens/hosting/00_hosing_screen.dart';
//import 'package:test/test.dart';
import '00_hosting_screen_2.dart';


void main() {
  testWidgets('Testing Hosting Screen !!', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: HostingScreen2())
    );

    // Create the Finders.
    final titleFinder = find.text('Hosting Screen');
    final nCount = find.text('Screen');
    final messageFinder = find.text('Your Accommodations List');
    final noApartmentFinder = find.text('Register your accommodation, villa, suite or apartment.');
    final textFinder = find.byType(Text );

    expect(textFinder , findsNWidgets(4));
    expect(titleFinder, findsOneWidget);
    expect(nCount, findsNothing );
    expect(messageFinder, findsOneWidget);
    expect(noApartmentFinder, findsOneWidget);
  });
}

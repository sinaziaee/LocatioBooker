import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/hosting/00_hosing_screen.dart';
import 'package:loctio_booker/screens/hosting/01_resort_type_screen.dart';
import 'package:loctio_booker/screens/hosting/components/hosting_resort_type_item.dart';
import '';

void main() {
  testWidgets('Returns true if found floating action button',
      (WidgetTester tester) async {
    User user = User(
        firstName: 'sina',
        lastName: 'ziaee',
        email: 'sina@gmail.com',
        token: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b');

    await tester.pumpWidget(MaterialApp(
      home: HostingScreen(user),
    ));

    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byKey(Key('hosting_screen_key')), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    // expect(find.byType(FloatingActionButton), findsOneWidget);

    expect(find.byKey(Key('resort_type_screen_key')), findsOneWidget);
    expect(find.byType(HostingResortItem), findsNWidgets(8));

    await tester.tap(find.byKey(Key(ResortType.coastal)));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('resort_description_screen_key')), findsOneWidget);
    final nameFiled = find.byKey(Key('resort_name'));
    final descriptionFiled = find.byKey(Key('resort_description'));
    final priceFiled = find.byKey(Key('resort_price'));
    final areaFiled = find.byKey(Key('resort_area'));
    final submitDescriptionButton = find.byKey(Key('resort_description_submit'));

    expect(nameFiled, findsOneWidget);
    expect(descriptionFiled, findsOneWidget);
    expect(priceFiled, findsOneWidget);
    expect(areaFiled, findsOneWidget);
    expect(submitDescriptionButton, findsOneWidget);

    await tester.enterText(nameFiled, 'Red resort');
    await tester.enterText(descriptionFiled, 'best resort ever');
    await tester.enterText(priceFiled, '100');
    await tester.enterText(areaFiled, '200');
    await tester.pumpAndSettle();

    expect(find.text('Red resort'), findsOneWidget);

    await tester.tap(find.byKey(Key('resort_description_submit')));
    await tester.pumpAndSettle();

    // expect(find.byKey(Key('resort_type_screen_key')), findsOneWidget);

    // expect(find.byKey(Key('resort_identification_screen_key')), findsOneWidget);
    // expect(find.byKey(Key('submit_identification')), findsOneWidget);

        // Exceptions
    // expect(tester.takeException(), isAssertionError);


    // expect(find.text('What area is your residence located in?'), findsOneWidget, reason: 'we are in resort type screen');
    // expect(find.text('Your Accommodations List'), findsOneWidget, reason: 'if found we are still in hosting screen');
    // expect(find.byWidget(ResortTypeScreen(user)), findsOneWidget);
  });
}

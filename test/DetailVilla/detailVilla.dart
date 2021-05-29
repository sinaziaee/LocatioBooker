import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loctio_booker/screens/detailVilla/detail_villa_screen.dart';
import '../DetailVilla/detailVillaScreen3.dart';



void main() {
  testWidgets('Testing Detail_Villa Screen !!', (WidgetTester tester) async {

    await tester.pumpWidget(
        MaterialApp(home: detailVillaScreen3())
    );

    // Create the Finders.
    final aboutFinder = find.text('About');
    final titleFinder = find.text('Detail Villa');
    final villaSpaceFinder = find.text('Villa Space');
    final areaFinder = find.text('Area');
    final capacityFinder = find.text('Capacity');
    final textFinder = find.byType(Text );
    final iconFinder = find.byType(Icon);
    final sizedBoxFinder = find.byType(SizedBox);
    final rowFinder = find.byType(Row);
    final singlechildScrollFinder = find.byType(SingleChildScrollView);
    final homeIconFinder = find.byIcon(Icons.home);
    final plusoneFinder = find.byIcon(Icons.plus_one_sharp);
    final homeRepair = find.byIcon(Icons.home_repair_service);
    final homeoutlinedf = find.byIcon(Icons.home_outlined);
    final description = find.byIcon(Icons.description);

    //   بچه های بک آماده تست ها باشین

    expect(description , findsOneWidget);
    expect(homeoutlinedf , findsOneWidget);
    expect(homeRepair, findsOneWidget);
    expect(plusoneFinder, findsNothing);

    expect(aboutFinder , findsOneWidget);
    expect(homeIconFinder , findsNWidgets(3));
    expect(titleFinder, findsOneWidget);
    expect(textFinder , findsNWidgets(14));
    expect(iconFinder , findsNWidgets(7));
    expect(rowFinder , findsNWidgets(13));
    expect(villaSpaceFinder  , findsNWidgets(2));
    expect(capacityFinder , findsOneWidget);
    expect(sizedBoxFinder , findsNWidgets(23));
    expect(areaFinder , findsOneWidget);
    expect(singlechildScrollFinder , findsNWidgets(2));

  });
}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loctio_booker/constants.dart';
import 'package:loctio_booker/models/facilitation.dart';
import 'package:loctio_booker/models/place_address.dart';
import 'package:loctio_booker/models/resort_description.dart';
import 'package:loctio_booker/models/resort_identification.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/hosting/00_hosing_screen.dart';
import 'package:loctio_booker/screens/hosting/01_resort_type_screen.dart';
import 'package:loctio_booker/screens/hosting/02_resort_description_screen.dart';
import 'package:loctio_booker/screens/hosting/03_identification_screen.dart';
import 'package:loctio_booker/screens/hosting/04_facilitation_screen.dart';
import 'package:loctio_booker/screens/hosting/05_place_address_screen.dart';
import 'package:loctio_booker/screens/hosting/06_gallery_screen.dart';
import 'package:loctio_booker/screens/hosting/07_identity_screen.dart';
import 'package:loctio_booker/screens/hosting/components/hosting_resort_type_item.dart';
import '';

void main() {
  group('Component testing profile screen\n', () {
    testWidgets('profile screen', (WidgetTester tester) async {
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
    });

    testWidgets('testing upload in profile', (WidgetTester tester) async {
      User user = User(
          firstName: 'sina',
          lastName: 'ziaee',
          email: 'sina@gmail.com',
          token: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b');

      await tester.pumpWidget(MaterialApp(
        home: ResortTypeScreen(user),
      ));

      expect(find.byKey(Key('resort_type_screen_key')), findsOneWidget);
      expect(find.byType(HostingResortItem), findsNWidgets(8));
    });

    testWidgets('resort description screen', (WidgetTester tester) async {
      User user = User(
          firstName: 'sina',
          lastName: 'ziaee',
          email: 'sina@gmail.com',
          token: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b');

      ResortDescription rd = ResortDescription(
        name: 'Red resort',
        price: 100,
        about: 'The best in town',
        area: 200,
      );

      await tester.pumpWidget(MaterialApp(
        home: ResortDescriptionScreen('Coastal', user),
      ));

      expect(find.byKey(Key('resort_description_screen_key')), findsOneWidget);
    });

    testWidgets('resort identification screen', (WidgetTester tester) async {
      User user = User(
          firstName: 'sina',
          lastName: 'ziaee',
          email: 'sina@gmail.com',
          token: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b');

      ResortDescription rd = ResortDescription(
        name: 'Red resort',
        price: 100,
        about: 'The best in town',
        area: 200,
      );

      await tester.pumpWidget(MaterialApp(
        home: ResortIdentificationScreen(
          user: user,
          resortDescription: rd,
          villa: 'Coastal',
        ),
      ));

      expect(
          find.byKey(Key('resort_identification_screen_key')), findsOneWidget);
    });

    testWidgets('resort identification screen', (WidgetTester tester) async {
      User user = User(
          firstName: 'sina',
          lastName: 'ziaee',
          email: 'sina@gmail.com',
          token: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b');

      ResortDescription rd = ResortDescription(
        name: 'Red resort',
        price: 100,
        about: 'The best in town',
        area: 200,
      );

      await tester.pumpWidget(MaterialApp(
        home: ResortIdentificationScreen(
          user: user,
          resortDescription: rd,
          villa: 'Coastal',
        ),
      ));

      expect(
          find.byKey(Key('resort_identification_screen_key')), findsOneWidget);
    });

    testWidgets('resort facilitation screen', (WidgetTester tester) async {
      User user = User(
          firstName: 'sina',
          lastName: 'ziaee',
          email: 'sina@gmail.com',
          token: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b');

      ResortDescription rd = ResortDescription(
        name: 'Red resort',
        price: 100,
        about: 'The best in town',
        area: 200,
      );

      ResortIdentification ri = ResortIdentification(
        numShowers: 1,
        numRooms: 1,
        numDoubleBeds: 1,
        numSingleBeds: 1,
        numBathrooms: 1,
        mCapacity: 5,
        bCapacity: 2,
      );

      await tester.pumpWidget(MaterialApp(
        home: FacilitationScreen(
          user: user,
          resortDescription: rd,
          villa: 'Coastal',
          resortIdentification: ri,
        ),
      ));

      expect(find.byKey(Key('resort_facilitation_screen_key')), findsOneWidget);
    });

    testWidgets('resort place address screen', (WidgetTester tester) async {
      User user = User(
          firstName: 'sina',
          lastName: 'ziaee',
          email: 'sina@gmail.com',
          token: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b');

      ResortDescription rd = ResortDescription(
        name: 'Red resort',
        price: 100,
        about: 'The best in town',
        area: 200,
      );

      ResortIdentification ri = ResortIdentification(
        numShowers: 1,
        numRooms: 1,
        numDoubleBeds: 1,
        numSingleBeds: 1,
        numBathrooms: 1,
        mCapacity: 5,
        bCapacity: 2,
      );

      Facilitation facilitation = Facilitation(
        pool: true,
        fireplace: false,
        wifi: true,
        parking: false,
        cookingBasics: true,
      );

      await tester.pumpWidget(MaterialApp(
        home: PlaceAddressScreen(
          user: user,
          resortDescription: rd,
          villa: 'Coastal',
          resortIdentification: ri,
          facilitation: facilitation,
        ),
      ));

      expect(find.byKey(Key('resort_place_address_screen_key')), findsOneWidget);
    });

    testWidgets('testing date of birth ', (WidgetTester tester) async {
      User user = User(
          firstName: 'sina',
          lastName: 'ziaee',
          email: 'sina@gmail.com',
          token: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b');

      ResortDescription rd = ResortDescription(
        name: 'Red resort',
        price: 100,
        about: 'The best in town',
        area: 200,
      );

      ResortIdentification ri = ResortIdentification(
        numShowers: 1,
        numRooms: 1,
        numDoubleBeds: 1,
        numSingleBeds: 1,
        numBathrooms: 1,
        mCapacity: 5,
        bCapacity: 2,
      );

      Facilitation facilitation = Facilitation(
        pool: true,
        fireplace: false,
        wifi: true,
        parking: false,
        cookingBasics: true,
      );

      PlaceAddress pa = PlaceAddress(
        city: 'Mashhad',
        state: 'Khorasan Razavi Province',
        country: 'Iran',
        address: 'Malek Abad Street',
        postalCode: 1234567890,
      );

      await tester.pumpWidget(MaterialApp(
        home: GalleryScreen(
          user: user,
          resortDescription: rd,
          villa: 'Coastal',
          resortIdentification: ri,
          facilitation: facilitation,
          placeAddress: pa,
        ),
      ));

      expect(find.byKey(Key('resort_gallery_screen_key')), findsOneWidget);
    });

    testWidgets('testing upload image', (WidgetTester tester) async {
      User user = User(
          firstName: 'sina',
          lastName: 'ziaee',
          email: 'sina@gmail.com',
          token: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b');

      ResortDescription rd = ResortDescription(
        name: 'Red resort',
        price: 100,
        about: 'The best in town',
        area: 200,
      );

      ResortIdentification ri = ResortIdentification(
        numShowers: 1,
        numRooms: 1,
        numDoubleBeds: 1,
        numSingleBeds: 1,
        numBathrooms: 1,
        mCapacity: 5,
        bCapacity: 2,
      );

      Facilitation facilitation = Facilitation(
        pool: true,
        fireplace: false,
        wifi: true,
        parking: false,
        cookingBasics: true,
      );

      PlaceAddress pa = PlaceAddress(
        city: 'Mashhad',
        state: 'Khorasan Razavi Province',
        country: 'Iran',
        address: 'Malek Abad Street',
        postalCode: 1234567890,
      );

      await tester.pumpWidget(MaterialApp(
        home: IdentityScreen(
          user: user,
          resortDescription: rd,
          villa: 'Coastal',
          resortIdentification: ri,
          facilitation: facilitation,
          placeAddress: pa,
          haveUploadedUserIdentity: true,
          imageIds: [1, 2, 3],
        ),
      ));

      expect(find.byKey(Key('resort_identity_screen_key')), findsOneWidget);
    });

  });
}

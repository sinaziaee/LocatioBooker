import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loctio_booker/models/user.dart';
import 'package:loctio_booker/screens/hosting/01_resort_type_screen.dart';
import 'package:mockito/mockito.dart';


class MockNavigatorObserver extends Mock implements NavigatorObserver {}

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

  group('MainPage navigation tests', () {
    NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<void> _buildMainPage(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ResortTypeScreen(myUser),

        // This mocked observer will now receive all navigation events
        // that happen in our app.
        navigatorObservers: [mockObserver],
      ));

      // The tester.pumpWidget() call above just built our app widget
      // and triggered the pushObserver method on the mockObserver once.
      verify(mockObserver.didPush(any, any));
    }

    Future<void> _navigateToDetailsPage(WidgetTester tester) async {
      // Tap the button which should navigate to the details page.
      //
      // By calling tester.pumpAndSettle(), we ensure that all animations
      // have completed before we continue further.


      //await tester.tap(find.byKey(ResortTypeScreen.navigateToDetailsButtonKey));
      await tester.pumpAndSettle();
    }

    testWidgets(
        'when tapping "navigate to details" button, should navigate to details page',
            (WidgetTester tester) async {
          // TODO: Write the test case here.
        });
  });
}
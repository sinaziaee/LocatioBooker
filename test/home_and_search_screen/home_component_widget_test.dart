import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../lib/models/user.dart';
import '../../lib/screens/home/home_screen.dart';

void main(){
  group('Component testing home screen', () {
    testWidgets('hosting screen', (WidgetTester tester) async {
      User user = User(
          firstName: 'sina',
          lastName: 'ziaee',
          email: 'sina@gmail.com',
          token: 'Token 624ce015857f931f52be05c0925cdcab47ebbf0b');

      await tester.pumpWidget(MaterialApp(
        home: HomeScreen(),
      ));
      // expect(find.byKey(Key('bnbi_profile')), findsOneWidget);
      // expect(find.byKey(Key('bnbi_villa')), findsOneWidget);
      // expect(find.byKey(Key('bnbi_home')), findsOneWidget);
      // expect(find.byKey(Key('bottom_navigation')), findsOneWidget);
      expect(find.byKey(Key('home_screen_key')), findsOneWidget);
      //
      // await tester.tap(find.byKey(Key('bnbi_profile')));
      // await tester.pumpAndSettle();
      //
      // expect(find.byKey(Key('key_account_settings')), findsOneWidget);

    });
  });

  // bnbi_profile
}
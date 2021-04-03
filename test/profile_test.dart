import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loctio_booker/models/user.dart';

import 'package:loctio_booker/screens/authentication/sign_up_screen.dart';
import 'package:loctio_booker/screens/profile/profile.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('This is a widget tester for profile screen',
          (WidgetTester tester) async {
        Widget createWidgetForTesting({Widget child}) {
          return MaterialApp(
            home: child,
          );
        }
        User user = User(
            firstName: 'sina',
            lastName: 'ziaee',
            phone: 'phone',
            country: 'country',
            gender: 'male',
            password: 'password',
            email: 'sina@gmail.com');
        // Test code goes here.
        ProfileScreen.id = 'this is a test for profile';
        await tester.pumpWidget(createWidgetForTesting(
            child: ProfileScreen()));

        // await tester.pumpWidget(createWidgetForTesting(child: SignUpScreen()));

      });
}

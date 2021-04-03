import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loctio_booker/models/user.dart';

// import 'package:loctio_booker/screens/authentication/login_screen.dart';
import 'package:loctio_booker/screens/authentication/sign_up_screen.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('This is a widget tester for signUp screen',
      (WidgetTester tester) async {
    Widget createWidgetForTesting({Widget child}) {
      return MaterialApp(
        home: child,
      );
    }

    // Test code goes here.
    await tester.pumpWidget(createWidgetForTesting(
        child: SignUpScreen.user(User(
            firstName: 'sina',
            lastName: 'ziaee',
            phone: 'phone',
            country: 'country',
            gender: 'male',
            password: 'password',
            email: 'sina@gmail.com'))));

  });
}

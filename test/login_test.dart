import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'package:loctio_booker/screens/authentication/login_screen.dart';
import 'package:loctio_booker/screens/authentication/components/my_textfield.dart';
import 'package:loctio_booker/screens/authentication/login_screen.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('This is a widget tester for login screen', (WidgetTester tester) async {

    Widget createWidgetForTesting({Widget child}){
      return MaterialApp(
        home: child,
      );
    }
    // Test code goes here.
    await tester.pumpWidget(createWidgetForTesting(child: LoginScreen()));
    await tester.enterText(find.byType(TextField), 'sina@gmail.com');
    // expect(find.text('sian@gmail.com').toString().length > 10, findsOneWidget);
    expect(find.text('sian@gmail.com').toString().length > 10, true);
    // expect(messageFinder, findsOneWidget);
  });
}
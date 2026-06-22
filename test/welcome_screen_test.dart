
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tindpets/screens/welcome_screen.dart';

void main() {
  group('WelcomeScreen', () {
    testWidgets('WelcomeScreen has a "Comenzar ahora" button with blue background', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

      // Find the button by its text
      final buttonFinder = find.widgetWithText(FilledButton, 'Comenzar ahora');
      expect(buttonFinder, findsOneWidget);

      // Verify that "Comenzar ahora" button is present
      final buttonWidget = tester.widget<FilledButton>(buttonFinder);
      expect(buttonWidget.style?.backgroundColor?.resolve({MaterialState.pressed}), Colors.blueAccent); // Check for blueAccent
    });

    testWidgets('WelcomeScreen has a "Ya tengo una cuenta" button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

      final buttonFinder = find.widgetWithText(OutlinedButton, 'Ya tengo una cuenta');
      expect(buttonFinder, findsOneWidget);
    });
  });
}

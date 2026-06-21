import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tindpets/screens/welcome_screen.dart';

void main() {
  testWidgets('WelcomeScreen has a "Comenzar ahora" button with blue background', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

    // Verify that "Comenzar ahora" button is present
    expect(find.text('Comenzar ahora'), findsOneWidget);

    // Find the FilledButton widget to inspect its style
    final buttonFinder = find.byWidgetPredicate((widget) {
      if (widget is FilledButton) {
        // Check if the button's child contains the text 'Comenzar ahora'
        return widget.child is Text && (widget.child as Text).data == 'Comenzar ahora';
      }
      return false;
    });

    expect(buttonFinder, findsOneWidget);

    final filledButton = tester.widget<FilledButton>(buttonFinder);

    // Verify the background color is blue
    expect(filledButton.style?.backgroundColor?.resolve({}), Colors.blue);
  });

  testWidgets('WelcomeScreen has a "Ya tengo una cuenta" button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

    expect(find.text('Ya tengo una cuenta'), findsOneWidget);
  });
}

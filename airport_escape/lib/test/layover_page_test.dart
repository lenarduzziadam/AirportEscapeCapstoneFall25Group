import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:airport_escape/layover_page.dart';

void main() {
  group('LayoverPage Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(
        home: LayoverPage(),
      );
    }

    testWidgets('Layover page should display correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Verify page elements
      expect(find.text('Plan Your Layover'), findsOneWidget);
      expect(find.text('Layover Duration (hours)'), findsOneWidget);
      expect(find.text('Select Airport'), findsOneWidget);
    });

    testWidgets('Should show suggestion when airport is changed', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Tap dropdown to open it
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Select Denver
      await tester.tap(find.text('Denver (DEN)').last);
      await tester.pumpAndSettle();

      // Should show Denver suggestion
      expect(find.textContaining('Union Station, Denver'), findsOneWidget);
    });

    testWidgets('Should show directions button when suggestion appears', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Change airport to trigger suggestion
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Atlanta (ATL)').last);
      await tester.pumpAndSettle();

      // Should show directions button
      expect(find.text('Get Directions'), findsOneWidget);
      expect(find.text('See Map'), findsOneWidget);
    });

    testWidgets('Duration field should accept numeric input', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      // Enter duration
      await tester.enterText(find.byType(TextField), '3');
      await tester.pumpAndSettle();

      // Verify input
      expect(find.text('3'), findsOneWidget);
    });
  });
}
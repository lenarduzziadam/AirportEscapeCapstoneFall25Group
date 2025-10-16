import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:airport_escape/main.dart';
import 'package:airport_escape/landing_page.dart';

void main() {
  group('Airport Escape App Tests', () {
    /* Test App Creation: verify app launches successfully to proper landing page*/
    testWidgets('App should launch and show landing page', (WidgetTester tester) async {
      // Build the app and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Verify that the app launches with the correct title
      expect(find.text('Airport Escape'), findsOneWidget);
      
      // Verify that the welcome message is displayed
      expect(find.text('Welcome to Airport Escape!'), findsOneWidget);
    });

    /*Test Settings Drawer: verify it opens when tapped and contains expected options*/
    testWidgets('Settings drawer should open when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Tap the settings icon
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      // Verify drawer opens
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('General'), findsOneWidget);
    });
    
    /*Test Account Menu: verify it opens when tapped and contains expected options*/
    testWidgets('Account menu should show when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Tap the account icon
      await tester.tap(find.byIcon(Icons.account_circle));
      await tester.pumpAndSettle();

      // Verify account menu appears
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
    });
  });
}
// Flutter app entry point and theme setup
import 'package:flutter/material.dart';
// Import main landing page and widgets
import 'landing_page.dart';

// App-wide color constants
const kPrimaryColor = Color.fromARGB(255, 18, 71, 156);
const kBackgroundColor = Color(0xFFE0F7FA);

// Main function: launches the app
void main() {
  runApp(const MyApp());
}

// Root widget: sets up MaterialApp and theme
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Airport Escape, for passengers by passengers',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MyHomePage(), // 👈 Keep the original landing page
    );
  }
}

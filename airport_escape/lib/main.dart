import 'package:flutter/material.dart';

// Entry point of the app
void main(){
  runApp( MyApp() );
}

// Root widget for the application
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // MaterialApp sets up app-wide configuration
    return MaterialApp(
      title: 'Airport Escape',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Main color theme
      ),
      home: const MyHomePage(), // Main screen of the app
    );
  }
}
// Home page widget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic visual layout structure
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airport Escape',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Bold title text
            )),
        backgroundColor: const Color.fromARGB(255, 18, 71, 156), // Dark blue color for top bar
      ),
      backgroundColor: const Color(0xFFE0F7FA), // Light cyan background color
      body: const Center(
        child: Text('Welcome to Airport Escape!'), // Main welcome message
      ),
    );
  }
}
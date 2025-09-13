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


//class for the state of the home page
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic visual layout structure
    return Scaffold(
      // Drawer widget for settings menu (slides in from the leftside of screen)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            // Header for the settings drawer
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 18, 71, 156),
              ),
              child: Text('Settings', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            // Settings options
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('General'),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Security'),
            ),
            // Add more settings options here
          ],
        ),
      ),
      appBar: AppBar(
        // Settings cog button in upper left, opens drawer
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: 'Open settings',
          ),
        ),
        // Bold app title in the center of the AppBar
        title: const Text('Airport Escape',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Bold title text
            )),
        backgroundColor: const Color.fromARGB(255, 18, 71, 156), // Dark blue color for top bar
        actions: [
          // Account dropdown button in the top right corner
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle, color: Colors.white,),
            onSelected: (String value) {
              // Handle account menu selection (Profile, Logout)
              if (value == 'Profile') {
                // Navigate to profile page or show profile
              } else if (value == 'Logout') {
                // Handle logout
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Profile',
                child: Text('Profile'),
              ),
              const PopupMenuItem<String>(
                value: 'Logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: const Color(0xFFE0F7FA), // Light cyan background color
      body: const Center( // Centered content in the body
        child: Text('Welcome to Airport Escape!'), // Main welcome message in the center of the screen
      ),
    );
  }
}
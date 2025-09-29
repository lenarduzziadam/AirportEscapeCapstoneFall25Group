// // Main landing page and widgets for Airport Escape app
import 'package:airport_escape/login_page.dart';
import 'package:airport_escape/user_account.dart';
import 'package:flutter/material.dart';

import 'search_bar_widget.dart';

import 'layover_page.dart'; // 👈 import your page

// App-wide color constants
const kPrimaryColor = Color.fromARGB(255, 18, 71, 156);
const kBackgroundColor = Color(0xFFE0F7FA);

// Main landing page widget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List of sample locations/keywords to search from
  final List<String> _sampleData = [
    "Restaurant",
    "Entertainment",
    "Relax",
    "Lounge",
    "Bar",
    "Gate A1",
    "Gate B2",
    "Coffee Shop",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SettingsDrawer(), // Side menu
      appBar: const CustomAppBar(), // Top app bar

      body: Column(
        children: [
          const SizedBox(height: 16.0),
          // Use the reusable SearchBarWidget for search functionality
          Expanded(
            child: SearchBarWidget(
              data: _sampleData,
              onResultTap: (result) {
                // TODO: Add navigation or actions for each result
                // For now, you can show a snackbar or print the result
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Selected: $result')));
              },
            ),
          ),
          // Welcome message (can be shown below or conditionally)
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'Welcome to Airport Escape!', // Welcome message
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // 👇 Your new button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LayoverPage()),
              );
            },
            child: const Text(
              "Plan My Layover",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ), 
        ],
      ),
    );
  }
}

// Drawer widget for settings menu
class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: kPrimaryColor),
            child: Text(
              'Settings',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings), // General settings option
            title: Text('General'),
          ),
          ListTile(
            leading: Icon(Icons.security), // Security settings option
            title: Text('Security'),
          ),
        ],
      ),
    );
  }
}

// Custom app bar widget for top navigation
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.settings, color: Colors.white), // Opens drawer
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: 'Open settings',
        ),
      ),
      title: const Text(
        'Airport Escape', // App title
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(
            Icons.account_circle,
            color: Colors.white,
          ), // Account icon
          onSelected: (String value) {
            // Handle account menu selection (Profile, Logout)
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Profile',
              child: Text('Profile'), // Profile option
            ),
            const PopupMenuItem<String>(
              value: 'Logout',
              child: Text('Logout'), // Logout option
            ),
          ],
        ),
      ],
    );
  }
}
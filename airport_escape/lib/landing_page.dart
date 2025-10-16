// Main landing page and widgets for Airport Escape app
import 'package:flutter/material.dart';

import 'search_bar_widget.dart';

import 'layover_page.dart'; 

import 'widgets/live_tip_button.dart';

// App-wide color constants
const kPrimaryColor = Color.fromARGB(255, 18, 71, 156);
const kBackgroundColor = Color(0xFFE0F7FA);

// Main landing page widget
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _openLayoverPage(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LayoverPage(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SettingsDrawer(),
      appBar: const CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
                'Welcome to Airport Escape!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _openLayoverPage(context, "Restaurant"),
              child: const Text("Restaurant"),
            ),
            ElevatedButton(
              onPressed: () => _openLayoverPage(context, "Entertainment"),
              child: const Text("Entertainment"),
            ),
            ElevatedButton(
              onPressed: () => _openLayoverPage(context, "Shopping"),
              child: const Text("Shopping"),
            ),
          ],
        ),
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
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Text('Settings',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('General'),
          ),
          ListTile(
            leading: Icon(Icons.security),
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
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: 'Open settings',
        ),
      ),
      title: const Text(
        'Airport Escape',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.account_circle, color: Colors.white),
          onSelected: (String value) {
            // Handle account menu selection (Profile, Logout)
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
    );
  }
}

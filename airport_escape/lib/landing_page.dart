// Main landing page and widgets for Airport Escape app
import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'search_bar_widget.dart';
import 'settings_menu.dart';
import 'layover_page.dart'; 

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
              child: Text(AppLocalizations.of(context)!.restaurant),
            ),
            ElevatedButton(
              onPressed: () => _openLayoverPage(context, "Entertainment"),
              child: Text(AppLocalizations.of(context)!.entertainment),
            ),
            ElevatedButton(
              onPressed: () => _openLayoverPage(context, "Shopping"),
              child: Text(AppLocalizations.of(context)!.shopping),
            ),
          ],
        ),
      ),
    );
  }
}


// Replace your existing SettingsDrawer class with this:
class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Text('Settings',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)!.general_settings),
            onTap: () {
              Navigator.pop(context); // Close drawer first
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: Text(AppLocalizations.of(context)!.security),
            onTap: () {
              Navigator.pop(context);
              // Add security page later if needed
            },
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
      title: Text(AppLocalizations.of(context)!.airport_escape,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.account_circle, color: Colors.white),
          onSelected: (String value) {
            // Handle account menu selection (Profile, Logout)
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'Profile',
              child: Text(AppLocalizations.of(context)!.profile),
            ),
            PopupMenuItem<String>(
              value: 'Logout',
              child: Text(AppLocalizations.of(context)!.logout),
            ),
          ],
        ),
      ],
    );
  }
}

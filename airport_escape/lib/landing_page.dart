// Main landing page and widgets for Airport Escape app
import 'package:flutter/material.dart';

// App-wide color constants
const kPrimaryColor = Color.fromARGB(255, 18, 71, 156);
const kBackgroundColor = Color(0xFFE0F7FA);

// Main landing page widget
// Main landing page widget with search bar skeleton
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Controller for the search bar input field
  final TextEditingController _searchController = TextEditingController();

  // List of sample locations/keywords to search from
  final List<String> _sampleData = [
    "Restaurant", "Entertainment", "Relax", "Massage", "Food", "Lounge", "Bar", "Gate A1", "Gate B2", "Coffee Shop"
  ];

  // Stores the filtered results based on search input
  List<String> _filteredResults = [];

  // Filters _sampleData as user types in the search bar
  // This function is called every time the search input changes
  // It updates _filteredResults with items that contain the search query (case-insensitive)
  void _filterResults(String query) {
    setState(() {
      _filteredResults = _sampleData
          .where((location) => location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SettingsDrawer(), // Side menu
      appBar: const CustomAppBar(),   // Top app bar
      body: Column(
        children: [
          const SizedBox(height: 16.0),

          /** Search bar at the top of the page 
          Uses a TextField for user input
          Calls _filterResults on every change to update the results. */
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for locations or keywords...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                // When the user types, filter the sample data
                _filterResults(value);
              },
            ),
          ),

          // List of filtered search results
          // - Only shows results that match the search query
          // - Each result is a ListTile (can be made clickable for navigation)
          Expanded(
            child: ListView.builder(
              itemCount: _filteredResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredResults[index]),
                  // for easy adding of navigation or actions here for each result
                );
              },
            ),
          ),

          // Welcome message (can be shown when no search is active or results are empty)
          Expanded(
            child: Center(
              child: Container(
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
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Text('Settings', style: TextStyle(color: Colors.white, fontSize: 24)),
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
          icon: const Icon(Icons.account_circle, color: Colors.white), // Account icon
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

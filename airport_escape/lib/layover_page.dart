import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'airport_dropdown.dart';
import 'dart:math';

class LayoverPage extends StatefulWidget {
  final String category; // 👈 category passed from landing page

  const LayoverPage({super.key, required this.category});

  @override
  State<LayoverPage> createState() => _LayoverPageState();
}

class _LayoverPageState extends State<LayoverPage> {
  final _durationController = TextEditingController();
  String _selectedAirport = "Chicago O'Hare (ORD)";
  String _suggestion = "";

  final List<String> airports = [
    "Chicago O'Hare (ORD)",
    "Denver (DEN)",
    "Atlanta (ATL)",
    "Dallas-Fort Worth (DFW)"
  ];

  // City → Category → Activities
  final Map<String, Map<String, List<String>>> cityActivities = {
    "Chicago O'Hare (ORD)": {
      "Restaurant": ["Giordano's Pizza", "Portillo's Hot Dogs"],
      "Entertainment": ["Millennium Park", "Navy Pier"],
      "Shopping": ["Water Tower Place", "Fashion Outlets of Chicago"],
    },
    "Denver (DEN)": {
      "Restaurant": ["Denver Central Market", "Snooze AM Eatery"],
      "Entertainment": ["Red Rocks Amphitheatre", "Union Station"],
      "Shopping": ["Cherry Creek Shopping Center", "16th Street Mall"],
    },
    "Atlanta (ATL)": {
      "Restaurant": ["Mary Mac's Tea Room", "The Varsity"],
      "Entertainment": ["Georgia Aquarium", "World of Coca-Cola"],
      "Shopping": ["Lenox Square Mall", "Ponce City Market"],
    },
    "Dallas-Fort Worth (DFW)": {
      "Restaurant": ["Pecan Lodge BBQ", "Joe T. Garcia's"],
      "Entertainment": ["AT&T Stadium", "Sixth Floor Museum"],
      "Shopping": ["Galleria Dallas", "NorthPark Center"],
    },
  };

  void _getSuggestions() {
    final activities = cityActivities[_selectedAirport]?[widget.category];
    if (activities != null && activities.isNotEmpty) {
      final random = Random();
      final chosen = activities[random.nextInt(activities.length)];
      setState(() {
        _suggestion =
            "Suggested ${widget.category} near $_selectedAirport: $chosen";
      });
    } else {
      setState(() {
        _suggestion =
            "No ${widget.category} activities found for $_selectedAirport.";
      });
    }
  }

  Future<void> _openDirections() async {
    if (_suggestion.isEmpty) return;

    final activity = _suggestion.split(": ").last;
    final query = Uri.encodeComponent(activity);
    final origin = Uri.encodeComponent(_selectedAirport);

    final url = Uri.parse(
      "https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$query",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch Google Maps")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plan Your Layover: ${widget.category}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _durationController,
              decoration: const InputDecoration(
                labelText: "Layover Duration (hours)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            buildAirportDropdown(
              selectedAirport: _selectedAirport,
              airports: airports,
              onAirportChanged: (newAirport) {
                setState(() {
                  _selectedAirport = newAirport;
                });
                _getSuggestions(); // ← Add this line
              },
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 24),
            if (_suggestion.isNotEmpty) ...[
              Text(
                _suggestion,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _openDirections,
                icon: const Icon(Icons.directions),
                label: const Text("Get Directions"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

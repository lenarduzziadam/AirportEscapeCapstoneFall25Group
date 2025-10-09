import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  LatLng _selectedAirportLoc = LatLng(41.978600, -87.904800);
  String _suggestion = "";
  LatLng _activityLoc = LatLng(0, 0);

  final List<String> airports = [
    "Chicago O'Hare (ORD)",
    "Denver (DEN)",
    "Atlanta (ATL)",
    "Dallas-Fort Worth (DFW)"
  ];

  // hardcoded LatLng vals for each airport
  final Map<String, LatLng> airportLocations = {
    "Chicago O'Hare (ORD)": const LatLng(41.978600, -87.904800),
    "Denver (DEN)": const LatLng(39.861698, -104.672997),
    "Atlanta (ATL)": const LatLng(33.636700, -84.428101),
    "Dallas-Fort Worth (DFW)": const LatLng(32.896801, -97.038002),
  };

  // Simple hardcoded activities near each airport
  final Map<String, String> sampleActivities = {
    "Chicago O'Hare (ORD)": "Millennium Park, Chicago",
    "Denver (DEN)": "Union Station, Denver",
    "Atlanta (ATL)": "Georgia Aquarium, Atlanta",
    "Dallas-Fort Worth (DFW)": "AT&T Stadium, Arlington",
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

  // hardcoded LatLng vals for each activity
  final Map<String, LatLng> activityLocations = {
    "Millennium Park, Chicago": const LatLng(41.8825, -87.6225),
    "Union Station, Denver": const LatLng(39.753056, -105),
    "Georgia Aquarium, Atlanta": const LatLng(33.762778, -84.394722),
    "AT&T Stadium, Arlington": const LatLng(32.896801, -97.038002),
  };

  void _getSuggestionsKav() {
    setState(() {
      var activity = sampleActivities[_selectedAirport];
      _suggestion = "Suggested activity near $_selectedAirport: $activity";

      _activityLoc = activityLocations[activity]!;
    });
  }
  void _getSuggestionsJohn() {
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
                _getSuggestions(); 
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        startLocation: _selectedAirportLoc,
                        endLocation: _activityLoc,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.directions,color: Colors.white,),
                label: const Text(
                  "Get Directions",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                ),
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

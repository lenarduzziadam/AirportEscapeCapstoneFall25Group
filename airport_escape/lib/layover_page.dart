import 'package:airport_escape/main.dart';
import 'package:airport_escape/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LayoverPage extends StatefulWidget {
  const LayoverPage({super.key});

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
    "Dallas-Fort Worth (DFW)",
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
  };

  // hardcoded LatLng vals for each activity
  final Map<String, LatLng> activityLocations = {
    "Millennium Park, Chicago": const LatLng(41.8825, -87.6225),
    "Union Station, Denver": const LatLng(39.753056, -105),
    "Georgia Aquarium, Atlanta": const LatLng(33.762778, -84.394722),
    "AT&T Stadium, Arlington": const LatLng(32.896801, -97.038002),
  };

  void _getSuggestions() {
    setState(() {
      var activity = sampleActivities[_selectedAirport];
      _suggestion = "Suggested activity near $_selectedAirport: $activity";

      _activityLoc = activityLocations[activity]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Plan Your Layover")),
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
            DropdownButtonFormField<String>(
              initialValue: _selectedAirport,
              items: airports
                  .map(
                    (airport) =>
                        DropdownMenuItem(value: airport, child: Text(airport)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAirport = value!;
                  _selectedAirportLoc = airportLocations[_selectedAirport]!;
                  _suggestion = "";
                  _activityLoc = LatLng(0, 0);
                });
              },
              decoration: const InputDecoration(
                labelText: "Select Airport",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getSuggestions,
              child: const Text("Get Suggestions"),
            ),
            const SizedBox(height: 24),
            if (_suggestion.isNotEmpty) ...[
              Text(
                _suggestion,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
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
            ],
          ],
        ),
      ),
    );
  }
}

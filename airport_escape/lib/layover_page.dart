import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class LayoverPage extends StatefulWidget {
  final String category; // passed from landing page

  const LayoverPage({super.key, required this.category});

  @override
  State<LayoverPage> createState() => _LayoverPageState();
}

class _LayoverPageState extends State<LayoverPage> {
  final _durationController = TextEditingController();
  String _selectedAirport = "Chicago O'Hare (ORD)";
  String _suggestion = "";
  String _distanceNote = "";

  final List<String> airports = [
    "Chicago O'Hare (ORD)",
    "Denver (DEN)",
    "Atlanta (ATL)",
    "Dallas-Fort Worth (DFW)"
  ];

  // Expanded city -> category -> activities (name + distance in miles)
  final Map<String, Map<String, List<Map<String, dynamic>>>> cityActivities = {
    "Chicago O'Hare (ORD)": {
      "Restaurant": [
        {"name": "Giordano's Pizza", "distance": 15},
        {"name": "Portillo's Hot Dogs", "distance": 8},
        {"name": "Lou Malnati's Pizzeria", "distance": 16},
        {"name": "The Purple Pig", "distance": 18},
      ],
      "Entertainment": [
        {"name": "Millennium Park", "distance": 17},
        {"name": "Navy Pier", "distance": 19},
        {"name": "Art Institute of Chicago", "distance": 17},
        {"name": "Chicago Riverwalk", "distance": 18},
      ],
      "Shopping": [
        {"name": "Water Tower Place", "distance": 18},
        {"name": "Fashion Outlets of Chicago", "distance": 4},
        {"name": "Magnificent Mile", "distance": 17},
        {"name": "Block 37", "distance": 18},
      ],
    },
    "Denver (DEN)": {
      "Restaurant": [
        {"name": "Denver Central Market", "distance": 23},
        {"name": "Snooze AM Eatery", "distance": 15},
        {"name": "Root Down", "distance": 14},
        {"name": "The Cherry Cricket", "distance": 17},
      ],
      "Entertainment": [
        {"name": "Red Rocks Amphitheatre", "distance": 25},
        {"name": "Union Station", "distance": 19},
        {"name": "Denver Art Museum", "distance": 18},
        {"name": "Downtown Aquarium", "distance": 20},
      ],
      "Shopping": [
        {"name": "Cherry Creek Shopping Center", "distance": 21},
        {"name": "16th Street Mall", "distance": 18},
        {"name": "Stanley Marketplace", "distance": 10},
        {"name": "Denver Pavilions", "distance": 17},
      ],
    },
    "Atlanta (ATL)": {
      "Restaurant": [
        {"name": "Mary Mac's Tea Room", "distance": 12},
        {"name": "The Varsity", "distance": 10},
        {"name": "South City Kitchen", "distance": 13},
        {"name": "Busy Bee Cafe", "distance": 11},
      ],
      "Entertainment": [
        {"name": "Georgia Aquarium", "distance": 14},
        {"name": "World of Coca-Cola", "distance": 13},
        {"name": "Centennial Olympic Park", "distance": 12},
        {"name": "Fox Theatre", "distance": 13},
      ],
      "Shopping": [
        {"name": "Lenox Square Mall", "distance": 16},
        {"name": "Ponce City Market", "distance": 12},
        {"name": "Atlantic Station", "distance": 13},
        {"name": "Perimeter Mall", "distance": 20},
      ],
    },
    "Dallas-Fort Worth (DFW)": {
      "Restaurant": [
        {"name": "Pecan Lodge BBQ", "distance": 23},
        {"name": "Joe T. Garcia's", "distance": 17},
        {"name": "Velvet Taco", "distance": 18},
        {"name": "Truck Yard", "distance": 20},
      ],
      "Entertainment": [
        {"name": "AT&T Stadium", "distance": 15},
        {"name": "Sixth Floor Museum", "distance": 22},
        {"name": "Dallas Arboretum", "distance": 19},
        {"name": "Fort Worth Stockyards", "distance": 21},
      ],
      "Shopping": [
        {"name": "Galleria Dallas", "distance": 19},
        {"name": "NorthPark Center", "distance": 20},
        {"name": "Shops at Clearfork", "distance": 18},
        {"name": "Grapevine Mills", "distance": 8},
      ],
    },
  };

  int _getDistanceLimit(double hours) {
    if (hours <= 3) return 10;
    if (hours <= 6) return 20;
    return 999;
  }

  void _getSuggestions() {
    final durationText = _durationController.text;
    if (durationText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your layover duration.")),
      );
      return;
    }

    final hours = double.tryParse(durationText) ?? 0;
    final distanceLimit = _getDistanceLimit(hours);

    final activities = cityActivities[_selectedAirport]?[widget.category];
    if (activities == null || activities.isEmpty) {
      setState(() {
        _suggestion =
            "No ${widget.category} activities found for $_selectedAirport.";
        _distanceNote = "";
      });
      return;
    }

    final filtered = activities
        .where((a) => (a["distance"] as int) <= distanceLimit)
        .toList();

    if (filtered.isEmpty) {
      setState(() {
        _suggestion =
            "No ${widget.category} options within ${distanceLimit} miles of $_selectedAirport.";
        _distanceNote =
            "Showing places within $distanceLimit miles for a ${hours.toStringAsFixed(1)}-hour layover.";
      });
    } else {
      final random = Random();
      final chosen = filtered[random.nextInt(filtered.length)]["name"];
      setState(() {
        _suggestion =
            "Suggested ${widget.category} near $_selectedAirport: $chosen";
        _distanceNote =
            "Showing places within $distanceLimit miles for a ${hours.toStringAsFixed(1)}-hour layover.";
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
            DropdownButtonFormField<String>(
              value: _selectedAirport,
              items: airports
                  .map((airport) => DropdownMenuItem(
                        value: airport,
                        child: Text(airport),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAirport = value!;
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
            const SizedBox(height: 10),
            if (_distanceNote.isNotEmpty)
              Text(
                _distanceNote,
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
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

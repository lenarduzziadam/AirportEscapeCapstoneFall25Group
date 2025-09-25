import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LayoverPage extends StatefulWidget {
  const LayoverPage({super.key});

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

  // Simple hardcoded activities near each airport
  final Map<String, String> sampleActivities = {
    "Chicago O'Hare (ORD)": "Millennium Park, Chicago",
    "Denver (DEN)": "Union Station, Denver",
    "Atlanta (ATL)": "Georgia Aquarium, Atlanta",
    "Dallas-Fort Worth (DFW)": "AT&T Stadium, Arlington"
  };

  void _getSuggestions() {
    setState(() {
      _suggestion =
          "Suggested activity near $_selectedAirport: ${sampleActivities[_selectedAirport]}";
    });
  }

  Future<void> _openDirections() async {
    final activity = sampleActivities[_selectedAirport];
    if (activity == null) return;

    final query = Uri.encodeComponent(activity);
    final url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$query");

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
        title: const Text("Plan Your Layover"),
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
            const SizedBox(height: 24),
            if (_suggestion.isNotEmpty) ...[
              Text(
                _suggestion,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

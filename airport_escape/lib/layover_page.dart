import 'package:flutter/material.dart';

class LayoverPage extends StatefulWidget {
  const LayoverPage({super.key});

  @override
  State<LayoverPage> createState() => _LayoverPageState();
}

class _LayoverPageState extends State<LayoverPage> {
  final TextEditingController _durationController = TextEditingController();
  String? _selectedAirport;
  String _resultMessage = "";

  final List<String> _airports = [
    'ORD - Chicago O\'Hare',
    'ATL - Atlanta',
    'DFW - Dallas/Fort Worth',
    'LAX - Los Angeles',
    'JFK - New York JFK',
  ];

  void _showSuggestions() {
    final duration = _durationController.text;
    if (_selectedAirport != null && duration.isNotEmpty) {
      setState(() {
        _resultMessage =
            "You selected $_selectedAirport with a layover of $duration hours.";
      });
    } else {
      setState(() {
        _resultMessage = "Please enter a duration and select an airport.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Layover Planner"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your layover details:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Layover Duration (hours)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _selectedAirport,
              hint: const Text("Select Airport"),
              items: _airports.map((airport) {
                return DropdownMenuItem(
                  value: airport,
                  child: Text(airport),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAirport = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: _showSuggestions,
                child: const Text("Get Suggestions"),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              _resultMessage,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

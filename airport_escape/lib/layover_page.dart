import 'package:airport_escape/activities_list.dart';
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
                });
              },
              decoration: const InputDecoration(
                labelText: "Select Airport",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ActivitiesList(
              key: ValueKey(_selectedAirport),
              airportCords: _selectedAirportLoc,
            ),
          ],
        ),
      ),
    );
  }
}

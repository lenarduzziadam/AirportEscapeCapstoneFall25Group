import 'package:flutter/material.dart';

class FlightInfoBox extends StatefulWidget {

  final Map<String, dynamic> flightData;

  const FlightInfoBox({super.key, required this.flightData});

  @override
  State<StatefulWidget> createState() => _FlightInfoBoxState();
}

class _FlightInfoBoxState extends State<FlightInfoBox> {
  Map<String, dynamic> get _flightData => widget.flightData;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Flight: ${_flightData['flight']?['iata'] ?? 'N/A'}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("Status: ${_flightData['flight_status'] ?? 'Unknown'}"),
            Text("Airline: ${_flightData['airline']?['name'] ?? 'N/A'}"),
            Text(
              "Departure: ${_flightData['departure']?['airport'] ?? 'N/A'} at ${_flightData['departure']?['estimated'] ?? 'N/A'}",
            ),
            Text(
              "Arrival: ${_flightData['arrival']?['airport'] ?? 'N/A'} at ${_flightData['arrival']?['estimated'] ?? 'N/A'}",
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Creates a reusable airport dropdown widget with automatic suggestion updates
Widget buildAirportDropdown({
  required String selectedAirport,
  required List<String> airports,
  required Function(String) onAirportChanged,
}) {
  return DropdownButtonFormField<String>(
    value: selectedAirport,
    items: airports
        .map((airport) => DropdownMenuItem(
              value: airport,
              child: Text(airport),
            ))
        .toList(),
    onChanged: (value) {
      if (value != null) {
        onAirportChanged(value);
      }
    },
    decoration: const InputDecoration(
      labelText: "Select Airport",
      border: OutlineInputBorder(),
    ),
  );
}
import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Creates a reusable airport dropdown widget with automatic suggestion updates
Widget buildAirportDropdown({
  required BuildContext context,
  required String selectedAirport,
  required List<String> airports,
  required Function(String) onAirportChanged,
}) {
  return DropdownButtonFormField<String>(
    value: selectedAirport,
    hint: Text(AppLocalizations.of(context)!.select_airport), // ← Grayed out placeholder
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
    decoration: InputDecoration(
      labelText: AppLocalizations.of(context)!.select_airport,
      border: OutlineInputBorder(),
    ),
  );
}
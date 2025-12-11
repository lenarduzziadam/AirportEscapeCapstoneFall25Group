import 'dart:convert';
import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:searchfield/searchfield.dart';

// ==========================
//  Airport Search Bar Widget
// ==========================

class AirportSearchBarWidget extends StatefulWidget {
  final Function(String, LatLng) onAirportChanged;

  const AirportSearchBarWidget({super.key, required this.onAirportChanged});

  @override
  State<AirportSearchBarWidget> createState() =>
      _AirportSearchBarWidgetState();
}

class _AirportSearchBarWidgetState extends State<AirportSearchBarWidget> {
  List<SearchFieldListItem<Airport>> _airports = [];
  SearchFieldListItem<Airport>? _selectedValue;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchairports();
  }

  // ==========================================
  //   LOAD AIRPORTS FROM LOCAL JSON (NO API)
  // ==========================================
  Future<void> _fetchairports() async {
    try {
      final dataString =
          await rootBundle.loadString("assets/data/airports.json");

      final Map<String, dynamic> jsonMap = json.decode(dataString);
      final List<SearchFieldListItem<Airport>> airports = [];

      jsonMap.forEach((code, ap) {
        if (ap["lat"] != null && ap["lon"] != null) {
          final airport = Airport(
            "${ap["name"]} (${ap["iata"] ?? "N/A"})",
            LatLng(
              (ap["lat"]).toDouble(),
              (ap["lon"]).toDouble(),
            ),
          );

          airports.add(
            SearchFieldListItem<Airport>(
              airport.name,
              item: airport,
              child: ListTile(title: Text(airport.name)),
            ),
          );
        }
      });

      setState(() {
        _airports = airports;
        _loading = false;
      });

      debugPrint("✅ Loaded ${airports.length} airports from assets JSON");
    } catch (e) {
      debugPrint("❌ Airport load ERROR: $e");
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SearchField<Airport>(
      suggestions: _airports,
      suggestionState: Suggestion.expand,
      maxSuggestionBoxHeight: 300,
      onSuggestionTap: (item) {
        setState(() => _selectedValue = item);

        final selectedAirport = item.item!;
        widget.onAirportChanged(
          selectedAirport.name,
          selectedAirport.location,
        );
      },
      searchInputDecoration: SearchInputDecoration(
        hintText: AppLocalizations.of(context)!.select_airport,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: const Icon(Icons.flight_takeoff),
      ),
      itemHeight: 50,
      // filtering logic
      onSearchTextChanged: (query) {
        return _airports
            .where((airport) =>
                airport.item!.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
    );
  }
}

// ==========================
//   Airport Model
// ==========================

class Airport {
  final String name;
  final LatLng location;

  Airport(this.name, this.location);
}

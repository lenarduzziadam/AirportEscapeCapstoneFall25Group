import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:searchfield/searchfield.dart';

class AirportSearchBarWidget extends StatefulWidget {
  final Function(String, LatLng) onAirportChanged;

  const AirportSearchBarWidget({
    super.key,
    required this.onAirportChanged,
  });

  @override
  State<AirportSearchBarWidget> createState() => _AirportSearchBarWidgetState();
}

class _AirportSearchBarWidgetState extends State<AirportSearchBarWidget> {
  List<SearchFieldListItem<Airport>> _airports = [];
  SearchFieldListItem<Airport>? _selectedValue;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAirportJson();
  }

  /// ===============================
  /// LOAD JSON FROM assets/data/airports.json
  /// ===============================
  Future<void> _loadAirportJson() async {
    try {
      // Correct path (you confirmed this)
      final String jsonString =
          await rootBundle.loadString("assets/data/airports.json");

      // Your JSON is a MAP, not a LIST
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      final List<SearchFieldListItem<Airport>> loadedAirports =
          jsonMap.entries.map((entry) {
        final airport = entry.value;

        final ap = Airport(
          airport["name"],
          LatLng(
            (airport["lat"] as num).toDouble(),
            (airport["lon"] as num).toDouble(),
          ),
        );

        return SearchFieldListItem<Airport>(
          ap.name,
          value: ap.name,
          item: ap,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(ap.name),
          ),
        );
      }).toList();

      setState(() {
        _airports = loadedAirports;
        _loading = false;
      });
    } catch (e) {
      debugPrint("❌ Airport load error: $e");
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SearchField<Airport>(
      suggestions: _airports
          .map(
            (item) => item.copyWith(
              value: item.value,
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(item.item!.name),
              ),
            ),
          )
          .toList(),

      selectedValue: _selectedValue,
      suggestionState: Suggestion.expand,
      maxSuggestionBoxHeight: 260,

      searchInputDecoration: SearchInputDecoration(
        hintText: "Search airport",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: const Icon(Icons.flight_takeoff),
      ),

      onSuggestionTap: (SearchFieldListItem<Airport> item) {
        setState(() => _selectedValue = item);

        widget.onAirportChanged(
          item.item!.name,
          item.item!.location,
        );
      },

      onSearchTextChanged: (text) {
        if (text.isEmpty) return _airports;

        return _airports
            .where((item) =>
                item.item!.name.toLowerCase().contains(text.toLowerCase()))
            .toList();
      },
    );
  }
}

class Airport {
  final String name;
  final LatLng location;

  Airport(this.name, this.location);
}

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:searchfield/searchfield.dart';
import 'package:flutter/material.dart';

// This widget provides a reusable search bar for filtering a list of terms (e.g., locations, keywords).
// It displays a TextField for user input and a scrollable list of matching results below.

// SearchBarWidget: A reusable search bar with filtering logic
class AirportSearchBarWidget extends StatefulWidget {
  final Function(String, LatLng) onAirportChanged;
  const AirportSearchBarWidget({super.key, required this.onAirportChanged});

  @override
  State<AirportSearchBarWidget> createState() => _AirportSearchBarWidgetState();
}

class _AirportSearchBarWidgetState extends State<AirportSearchBarWidget> {
  // Controller for the search bar input field
  var _airports = <SearchFieldListItem<Airport>>[];
  SearchFieldListItem<Airport>? _selectedValue;
  bool _loading = true;

  Widget _searchChild(Airport airport, {bool isSelected = false}) => ListTile(
    contentPadding: EdgeInsets.all(0),
    title: Text(
      airport.name,
      style: TextStyle(color: isSelected ? Colors.green : null),
    ),
  );

  @override
  void initState() {
    super.initState();
    _fetchairports();
  }

  Future<void> _fetchairports() async {
    try {
      final apiKey = dotenv.env['AVIATIONSTACK_KEY'];
      final response = await http.get(
        Uri.parse(
          'https://api.aviationstack.com/v1/airports?access_key=$apiKey'
          '&limit=30000',
        ),
      );
      if (response.statusCode == 200) {
        final responseList = json.decode(response.body);
        final List<dynamic> data = responseList['data'];
        final List<SearchFieldListItem<Airport>> airports = data
            .where(
              (json) =>
                  json['latitude'] != null &&
                  json['longitude'] != null &&
                  json['latitude'].toString().isNotEmpty &&
                  json['longitude'].toString().isNotEmpty,
            )
            .map((json) {
              LatLng airportCords = LatLng(
                double.parse(json['latitude']),
                double.parse(json['longitude']),
              );

              var name = "${json['airport_name']} (${json['iata_code']})";
              final airport = Airport(name, airportCords);
              return SearchFieldListItem<Airport>(
                airport.name,
                item: airport,
                child: _searchChild(airport, isSelected: false),
              );
            })
            .toList();

        setState(() {
          _airports = airports;
          _loading = false;
        });
      } else {
        throw Exception('Failed to load airports');
      }
    } catch (e) {
      debugPrint('Error fetching airports: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return SearchField(
      suggestionsDecoration: SuggestionDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        itemPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      maxSuggestionBoxHeight: 300,
      onSuggestionTap: (SearchFieldListItem<Airport> item) {
        setState(() {
          _selectedValue = item;
        });
        widget.onAirportChanged(item.item!.name, item.item!.location);
      },
      searchInputDecoration: SearchInputDecoration(
        hintText: 'Select an airport',
        suffix: Icon(Icons.expand_more),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      onSearchTextChanged: (searchText) {
        if (searchText.isEmpty) {
          return _airports;
        }
        final filter = _airports.where((airport) {
          return airport.item!.name.toLowerCase().contains(
            searchText.toLowerCase(),
          );
        }).toList();
        return filter;
      },
      selectedValue: _selectedValue,
      suggestions: _airports
          .map(
            (e) => e.copyWith(
              child: _searchChild(e.item!, isSelected: e == _selectedValue),
            ),
          )
          .toList(),
      suggestionState: Suggestion.expand,
    );
  }
}

class Airport {
  String name;
  LatLng location;
  Airport(this.name, this.location);
}

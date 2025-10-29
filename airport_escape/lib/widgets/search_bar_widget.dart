import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    _airports =
        [
          Airport("Chicago O'Hare (ORD)", const LatLng(41.978600, -87.904800)),
          Airport("Denver (DEN)", const LatLng(39.861698, -104.672997)),
          Airport("Atlanta (ATL)", const LatLng(33.636700, -84.428101)),
          Airport(
            "Dallas-Fort Worth (DFW)",
            const LatLng(32.896801, -97.038002),
          ),
        ].map((Airport ap) {
          return SearchFieldListItem<Airport>(
            ap.name,
            value: ap.name,
            item: ap,
            child: _searchChild(ap, isSelected: false),
          );
        }).toList();
  }

  @override
  Widget build(BuildContext context) {
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
          return _airports
              .map(
                (e) => e.copyWith(
                  child: _searchChild(e.item!, isSelected: e == _selectedValue),
                ),
              )
              .toList();
        }
        // filter the list of cities by the search text
        final filter = List<SearchFieldListItem<Airport>>.from(_airports).where(
          (city) {
            return city.item!.name.toLowerCase().contains(
                  searchText.toLowerCase(),
                ) ||
                city.item!.location.toString().contains(searchText);
          },
        ).toList();
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

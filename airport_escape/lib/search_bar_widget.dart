import 'package:flutter/material.dart';

// This widget provides a reusable search bar for filtering a list of terms (e.g., locations, keywords).
// It displays a TextField for user input and a scrollable list of matching results below.

// SearchBarWidget: A reusable search bar with filtering logic
class SearchBarWidget extends StatefulWidget {
  // List of terms to search from
  final List<String> data;
  // Callback when a result is tapped
  final void Function(String) onResultTap;

  const SearchBarWidget({
    super.key,
    required this.data,
    required this.onResultTap,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  // Controller for the search bar input field
  final TextEditingController _searchController = TextEditingController();
  // Stores the filtered results based on search input
  List<String> _filteredResults = [];

  @override
  void initState() {
    super.initState();
    // Initially show all terms before any search
    _filteredResults = widget.data;
  }

  // Filters the provided data as user types in the search bar
  // Only terms containing the query (case-insensitive) are shown
  void _filterResults(String query) {
    setState(() {
      _filteredResults = widget.data
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar input field
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for locations or keywords...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: _filterResults, // Calls filter on every text change
          ),
        ),
        // List of filtered search results
        Expanded(
          child: ListView.builder(
            itemCount: _filteredResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_filteredResults[index]),
                onTap: () => widget.onResultTap(_filteredResults[index]), // Callback for result tap
              );
            },
          ),
        ),
      ],
    );
  }
}

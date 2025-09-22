import 'package:flutter/material.dart';

// SearchBarWidget: A reusable search bar with filtering logic
class SearchBarWidget extends StatefulWidget {
  final List<String> data;
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
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredResults = [];

  @override
  void initState() {
    super.initState();
    _filteredResults = widget.data;
  }

  // Filters the provided data as user types
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
            onChanged: _filterResults,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_filteredResults[index]),
                onTap: () => widget.onResultTap(_filteredResults[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

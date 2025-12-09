import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:airport_escape/timer_service.dart';
import 'package:airport_escape/widgets/activities_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/search_bar_widget.dart';

class LayoverPage extends StatefulWidget {
  const LayoverPage({super.key});

  @override
  State<LayoverPage> createState() => _LayoverPageState();
}

class _LayoverPageState extends State<LayoverPage> {
  final _durationController = TextEditingController();
  double _duration = 0;

  String _selectedAirport = "";
  late LatLng _selectedAirportLoc;

  String _selectedCategory = "";
  List<String> get _categories => [
    AppLocalizations.of(context)!.restaurant,
    AppLocalizations.of(context)!.entertainment,
    AppLocalizations.of(context)!.shopping,
  ];
  List<String> _favorites = [];

  bool _isOnlyInAirport = false;

  // ======================= FAVORITES =======================

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> _saveFavorite(String place) async {
    final prefs = await SharedPreferences.getInstance();
    if (!_favorites.contains(place)) {
      setState(() => _favorites.add(place));
      await prefs.setStringList('favorites', _favorites);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$place added to favorites')));
    }
  }

  Future<void> _removeFavorite(String place) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _favorites.remove(place));
    await prefs.setStringList('favorites', _favorites);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$place removed')));
  }

  void _showFavorites() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Favorites"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: _favorites.isEmpty
                ? [const Text("No favorites yet.")]
                : _favorites
                      .map(
                        (f) => ListTile(
                          title: Text(f),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeFavorite(f),
                          ),
                        ),
                      )
                      .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  // ======================= LIFECYCLE =======================

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  // ======================= BUILD UI =======================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.plan_your_layover,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            tooltip: "Favorites",
            onPressed: _showFavorites,
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ----- Category Dropdown -----
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedCategory = value);
                    }
                  },
                ),

                const SizedBox(height: 8),

                // ----- Duration Input -----
                TextField(
                  controller: _durationController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(
                      context,
                    )!.layover_duration_label,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() => _duration = double.parse(value));
                    }
                  },
                ),

                const SizedBox(height: 8),

                // ----- Airport Search -----
                AirportSearchBarWidget(
                  onAirportChanged: (airport, loc) {
                    setState(() {
                      _selectedAirport = airport;
                      _selectedAirportLoc = loc;
                    });
                  },
                ),

                const SizedBox(height: 8),

                // is in only airport box
                Text("Only in airport", textAlign: TextAlign.center),

                // =========================================================
                // UBER + LYFT BUTTONS with auto-filled pickup
                // =========================================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Uber Button
                    ElevatedButton.icon(
                      onPressed: () {
                        final lat = _selectedAirportLoc.latitude;
                        final lng = _selectedAirportLoc.longitude;
                        final encoded = Uri.encodeComponent(_selectedAirport);

                        final uberUrl = Uri.parse(
                          "https://m.uber.com/ul/?action=setPickup"
                          "&pickup[latitude]=$lat"
                          "&pickup[longitude]=$lng"
                          "&pickup[nickname]=$encoded",
                        );

                        launchUrl(
                          uberUrl,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      icon: const Icon(Icons.local_taxi),
                      label: const Text("Uber"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                    ),

                    // is in only airport checkbox
                    Checkbox(
                      value: _isOnlyInAirport,
                      onChanged: (bool? value) {
                        setState(() {
                          _isOnlyInAirport = value!;
                        });
                      },
                    ),

                    // Lyft Button
                    ElevatedButton.icon(
                      onPressed: () {
                        final lat = _selectedAirportLoc.latitude;
                        final lng = _selectedAirportLoc.longitude;

                        final lyftUrl = Uri.parse(
                          "https://ride.lyft.com/"
                          "?pickup[latitude]=$lat"
                          "&pickup[longitude]=$lng",
                        );

                        launchUrl(
                          lyftUrl,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      icon: const Icon(Icons.directions_car),
                      label: const Text("Lyft"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                if (_selectedAirport.isNotEmpty &&
                    _duration > 0 &&
                    _selectedCategory.isNotEmpty)
                  Expanded(
                    child: ActivitiesList(
                      key: ValueKey(
                        "$_selectedAirport _$_duration _$_selectedCategory _$_isOnlyInAirport",
                      ),
                      airportCords: _selectedAirportLoc,
                      duration: _duration,
                      category: _selectedCategory,
                      onActivitiesChanged: () {
                        TimerService().start(
                          seconds: (_duration * 3600).toInt(),
                        );
                      },
                      favorites: _favorites,
                      onFavorite: _saveFavorite,
                      isOnlyInAirport: _isOnlyInAirport,
                    ),
                  ),
              ],
            ),
          ),

          // ======================= RETURN TIMER FLOATING BOX =======================
          /*
          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "⏰ Return Timer",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    _remainingTimeText,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          */
        ],
      ),
    );
  }
}

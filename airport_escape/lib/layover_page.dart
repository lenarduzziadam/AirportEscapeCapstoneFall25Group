import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:airport_escape/widgets/activities_list.dart';
import 'package:airport_escape/widgets/flight_info_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'widgets/search_bar_widget.dart';

class LayoverPage extends StatefulWidget {

  const LayoverPage({super.key, });

  @override
  State<LayoverPage> createState() => _LayoverPageState();
}

class _LayoverPageState extends State<LayoverPage> {
  final _durationController = TextEditingController();
  final _flightController = TextEditingController();

  String _selectedAirport = "";
  late LatLng _selectedAirportLoc;

  double _duration = 0;
  Map<String, dynamic>? _flightData;

  Duration _remainingTime = Duration.zero;
  Timer? _countdownTimer;
  bool _loadingFlight = false;
  List<String> _favorites = [];

  String _selectedCategory = "";
  List<String> get _categories => [
    AppLocalizations.of(context)!.restaurant,
    AppLocalizations.of(context)!.entertainment,
    AppLocalizations.of(context)!.shopping,
  ];

  // ============= FAVORITES =================

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

  // ============= LAYOVER SUGGESTIONS =================

  void _startCountdown(double hours) {
    _countdownTimer?.cancel();
    setState(() => _remainingTime = Duration(hours: hours.floor()));

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds <= 0) {
        timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Layover over! Time to head to the airport."),
          ),
        );
      } else {
        setState(() => _remainingTime -= const Duration(seconds: 1));
      }
    });
  }

  // ============= FLIGHT API =================

  String? _loadApiKey() {
    try {
      return dotenv.env['AVIATIONSTACK_KEY'] ??
          const String.fromEnvironment('AVIATIONSTACK_KEY');
    } catch (_) {
      return const String.fromEnvironment('AVIATIONSTACK_KEY');
    }
  }

  Future<void> _fetchFlightInfo() async {
    final flightCode = _flightController.text.trim();
    if (flightCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a flight code (e.g. AA100)"),
        ),
      );
      return;
    }

    final apiKey = _loadApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Missing API key. Add via .env or --dart-define."),
        ),
      );
      return;
    }

    final url = Uri.parse(
      'https://api.aviationstack.com/v1/flights?access_key=$apiKey&flight_iata=$flightCode',
    );
    print("🌍 Request: $url");

    setState(() {
      _loadingFlight = true;
      _flightData = null;
    });

    try {
      final response = await http.get(url);
      print("📡 Status: ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data'].isNotEmpty) {
          setState(() => _flightData = data['data'][0]);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No flight data found.")),
          );
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error ${response.statusCode}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _loadingFlight = false);
    }
  }

  // ============= UI BUILD =================

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  String get _remainingTimeText {
    final h = _remainingTime.inHours;
    final m = _remainingTime.inMinutes.remainder(60);
    final s = _remainingTime.inSeconds.remainder(60);
    return _remainingTime == Duration.zero
        ? "Not set"
        : "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.plan_your_layover,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            tooltip: "View Favorites",
            onPressed: _showFavorites,
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // 🔽 CATEGORY DROPDOWN
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(),
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
                const SizedBox(height: 16),
                TextField(
                  controller: _durationController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(
                      context,
                    )!.layover_duration_label,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ], // Only numbers can be entered
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() => _duration = double.parse(value));
                    } else {
                      setState(() => _duration = 0);
                    }
                  },
                ),
                const SizedBox(height: 16),
                AirportSearchBarWidget(
                  onAirportChanged: (newAirport, newAirportLoc) {
                    setState(() {
                      _selectedAirport = newAirport;
                      _selectedAirportLoc = newAirportLoc;
                    });
                  },
                ),

                const SizedBox(height: 16),
                // flight info box
                const Text(
                  "Check Flight Info",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _flightController,
                  decoration: const InputDecoration(
                    labelText: "Enter Flight Code (e.g. AA100)",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: _loadingFlight ? null : _fetchFlightInfo,
                  icon: const Icon(Icons.flight_takeoff),
                  label: const Text("Check Flight Status"),
                ),
                if (_loadingFlight) const CircularProgressIndicator(),
                if (_flightData != null)
                  FlightInfoBox(
                    flightData: _flightData!,
                  ),
                const SizedBox(height: 16),
                if (_selectedAirport.isNotEmpty &&
                    _duration > 0 &&
                    _selectedCategory.isNotEmpty)
                  Expanded(
                    child: ActivitiesList(
                      key: ValueKey(
                        "${_selectedAirport}_$_duration _$_selectedCategory",
                      ),
                      airportCords: _selectedAirportLoc,
                      duration: double.parse(_durationController.text.trim()),
                      category: _selectedCategory,
                      onActivitiesChanged: () {
                        _startCountdown(_duration);
                      },
                      favorites: _favorites,
                      onFavorite: _saveFavorite,
                    ),
                  ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }
}

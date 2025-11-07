import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LayoverPage extends StatefulWidget {
  final String category;

  const LayoverPage({super.key, required this.category});

  @override
  State<LayoverPage> createState() => _LayoverPageState();
}

class _LayoverPageState extends State<LayoverPage> {
  final _durationController = TextEditingController();
  final _flightController = TextEditingController();

  String _selectedAirport = "Chicago O'Hare (ORD)";
  String _suggestion = "";
  String _distanceNote = "";
  Map<String, dynamic>? _flightData;

  LatLng _selectedAirportLoc = const LatLng(41.9786, -87.9048);
  Duration _remainingTime = Duration.zero;
  Timer? _countdownTimer;
  bool _loadingFlight = false;
  List<String> _favorites = [];

  final List<String> airports = [
    "Chicago O'Hare (ORD)",
    "Denver (DEN)",
    "Atlanta (ATL)",
    "Dallas-Fort Worth (DFW)"
  ];

  final Map<String, LatLng> airportLocations = {
    "Chicago O'Hare (ORD)": const LatLng(41.9786, -87.9048),
    "Denver (DEN)": const LatLng(39.861698, -104.672997),
    "Atlanta (ATL)": const LatLng(33.6367, -84.428101),
    "Dallas-Fort Worth (DFW)": const LatLng(32.896801, -97.038002),
  };

  final Map<String, Map<String, List<Map<String, dynamic>>>> cityActivities = {
    "Chicago O'Hare (ORD)": {
      "Restaurant": [
        {"name": "Giordano's Pizza", "distance": 15},
        {"name": "Portillo's Hot Dogs", "distance": 8},
        {"name": "Lou Malnati's Pizzeria", "distance": 16},
      ],
      "Entertainment": [
        {"name": "Millennium Park", "distance": 17},
        {"name": "Navy Pier", "distance": 19},
      ],
    },
    "Denver (DEN)": {
      "Restaurant": [
        {"name": "Root Down", "distance": 14},
        {"name": "The Cherry Cricket", "distance": 17},
      ],
      "Entertainment": [
        {"name": "Red Rocks Amphitheatre", "distance": 25},
        {"name": "Union Station", "distance": 19},
      ],
    },
  };

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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$place added to favorites')));
    }
  }

  Future<void> _removeFavorite(String place) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _favorites.remove(place));
    await prefs.setStringList('favorites', _favorites);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$place removed')));
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
                    .map((f) => ListTile(
                          title: Text(f),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeFavorite(f),
                          ),
                        ))
                    .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          )
        ],
      ),
    );
  }

  // ============= LAYOVER SUGGESTIONS =================

  int _getDistanceLimit(double hours) {
    if (hours <= 3) return 10;
    if (hours <= 6) return 20;
    return 999;
  }

  void _getSuggestions() {
    final durationText = _durationController.text;
    if (durationText.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter layover duration")));
      return;
    }

    final hours = double.tryParse(durationText) ?? 0;
    final distanceLimit = _getDistanceLimit(hours);
    final activities = cityActivities[_selectedAirport]?[widget.category];

    if (activities == null || activities.isEmpty) {
      setState(() => _suggestion = "No activities found.");
      return;
    }

    final filtered =
        activities.where((a) => (a["distance"] as int) <= distanceLimit).toList();
    if (filtered.isEmpty) {
      setState(() => _suggestion =
          "No ${widget.category} options within ${distanceLimit} miles.");
    } else {
      final chosen = filtered[Random().nextInt(filtered.length)]["name"];
      setState(() => _suggestion =
          "Suggested ${widget.category} near $_selectedAirport: $chosen");
    }

    _startCountdown(hours);
  }

  void _startCountdown(double hours) {
    _countdownTimer?.cancel();
    setState(() => _remainingTime = Duration(hours: hours.floor()));

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds <= 0) {
        timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Layover over! Time to head to the airport.")));
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
        const SnackBar(content: Text("Please enter a flight code (e.g. AA100)")),
      );
      return;
    }

    final apiKey = _loadApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Missing API key. Add via .env or --dart-define.")));
      return;
    }

    final url = Uri.parse(
        'https://api.aviationstack.com/v1/flights?access_key=$apiKey&flight_iata=$flightCode');
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
              const SnackBar(content: Text("No flight data found.")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error ${response.statusCode}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _loadingFlight = false);
    }
  }

  // ============= DIRECTIONS =================

  Future<void> _openDirections() async {
    if (_suggestion.isEmpty) return;
    final destination = Uri.encodeComponent(_suggestion.split(": ").last);
    final origin = Uri.encodeComponent(_selectedAirport);
    final url = Uri.parse(
        "https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination");

    if (await launcher.canLaunchUrl(url)) {
      await launcher.launchUrl(url,
          mode: launcher.LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open Google Maps.")));
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
        title: Text("Plan Your Layover: ${widget.category}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: _showFavorites,
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _durationController,
                    decoration: const InputDecoration(
                        labelText: "Layover Duration (hours)",
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedAirport,
                    decoration: const InputDecoration(
                      labelText: "Select Airport",
                      border: OutlineInputBorder(),
                    ),
                    items: airports
                        .map((a) => DropdownMenuItem(
                              value: a,
                              child: Text(a),
                            ))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        _selectedAirport = v!;
                        _selectedAirportLoc = airportLocations[v]!;
                        _suggestion = "";
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text("Check Flight Info",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _flightController,
                    decoration: const InputDecoration(
                        labelText: "Enter Flight Code (e.g. AA100)",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _loadingFlight ? null : _fetchFlightInfo,
                    icon: const Icon(Icons.flight_takeoff),
                    label: const Text("Check Flight Status"),
                  ),
                  if (_loadingFlight) const CircularProgressIndicator(),
                  if (_flightData != null)
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 12),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Flight: ${_flightData!['flight']?['iata'] ?? 'N/A'}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  "Status: ${_flightData!['flight_status'] ?? 'Unknown'}"),
                              Text(
                                  "Airline: ${_flightData!['airline']?['name'] ?? 'N/A'}"),
                              Text(
                                  "Departure: ${_flightData!['departure']?['airport'] ?? 'N/A'} at ${_flightData!['departure']?['estimated'] ?? 'N/A'}"),
                              Text(
                                  "Arrival: ${_flightData!['arrival']?['airport'] ?? 'N/A'} at ${_flightData!['arrival']?['estimated'] ?? 'N/A'}"),
                            ]),
                      ),
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: _getSuggestions,
                      child: const Text("Get Suggestions")),
                  if (_distanceNote.isNotEmpty)
                    Text(_distanceNote,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.black54)),
                  if (_suggestion.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(_suggestion,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                        onPressed: _openDirections,
                        icon: const Icon(Icons.directions),
                        label: const Text("Get Directions")),
                    ElevatedButton.icon(
                        onPressed: () => _saveFavorite(_suggestion),
                        icon: const Icon(Icons.star_border),
                        label: const Text("Save to Favorites")),
                  ],
                ],
              ),
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
                      color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("⏰ Return Timer",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87)),
                  Text(_remainingTimeText,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

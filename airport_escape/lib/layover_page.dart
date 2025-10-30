import 'package:airport_escape/widgets/activities_list.dart';
import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LayoverPage extends StatefulWidget {
  final String category; // passed from landing page

  const LayoverPage({super.key, required this.category});

  @override
  State<LayoverPage> createState() => _LayoverPageState();
}

class _LayoverPageState extends State<LayoverPage> {
  final _durationController = TextEditingController();
  String _selectedAirport = "Chicago O'Hare (ORD)";
  LatLng _selectedAirportLoc = const LatLng(41.978600, -87.904800);
  String _suggestion = "";
  String _distanceNote = "";
  LatLng _activityLoc = const LatLng(0, 0);

  // Countdown timer
  Timer? _countdownTimer;
  Duration _remainingTime = Duration.zero;
  List<String> _favorites = [];

  // Flight Info
  final _flightController = TextEditingController();
  Map<String, dynamic>? _flightData;
  bool _loadingFlight = false;

  String get _remainingTimeText {
    final hours = _remainingTime.inHours;
    final minutes = _remainingTime.inMinutes.remainder(60);
    final seconds = _remainingTime.inSeconds.remainder(60);
    if (_remainingTime == Duration.zero) return "Not set";
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  final List<String> airports = [
    "Chicago O'Hare (ORD)",
    "Denver (DEN)",
    "Atlanta (ATL)",
    "Dallas-Fort Worth (DFW)"
  ];

  final Map<String, LatLng> airportLocations = {
    "Chicago O'Hare (ORD)": const LatLng(41.978600, -87.904800),
    "Denver (DEN)": const LatLng(39.861698, -104.672997),
    "Atlanta (ATL)": const LatLng(33.636700, -84.428101),
    "Dallas-Fort Worth (DFW)": const LatLng(32.896801, -97.038002),
  };

  final Map<String, Map<String, List<Map<String, dynamic>>>> cityActivities = {
    "Chicago O'Hare (ORD)": {
      "Restaurant": [
        {"name": "Giordano's Pizza", "distance": 15},
        {"name": "Portillo's Hot Dogs", "distance": 8},
        {"name": "Lou Malnati's Pizzeria", "distance": 16},
        {"name": "The Purple Pig", "distance": 18},
      ],
      "Entertainment": [
        {"name": "Millennium Park", "distance": 17},
        {"name": "Navy Pier", "distance": 19},
        {"name": "Art Institute of Chicago", "distance": 17},
        {"name": "Chicago Riverwalk", "distance": 18},
      ],
      "Shopping": [
        {"name": "Water Tower Place", "distance": 18},
        {"name": "Fashion Outlets of Chicago", "distance": 4},
        {"name": "Magnificent Mile", "distance": 17},
        {"name": "Block 37", "distance": 18},
      ],
    },
    "Denver (DEN)": {
      "Restaurant": [
        {"name": "Denver Central Market", "distance": 23},
        {"name": "Snooze AM Eatery", "distance": 15},
        {"name": "Root Down", "distance": 14},
        {"name": "The Cherry Cricket", "distance": 17},
      ],
      "Entertainment": [
        {"name": "Red Rocks Amphitheatre", "distance": 25},
        {"name": "Union Station", "distance": 19},
        {"name": "Denver Art Museum", "distance": 18},
        {"name": "Downtown Aquarium", "distance": 20},
      ],
      "Shopping": [
        {"name": "Cherry Creek Shopping Center", "distance": 21},
        {"name": "16th Street Mall", "distance": 18},
        {"name": "Stanley Marketplace", "distance": 10},
        {"name": "Denver Pavilions", "distance": 17},
      ],
    },
    "Atlanta (ATL)": {
      "Restaurant": [
        {"name": "Mary Mac's Tea Room", "distance": 12},
        {"name": "The Varsity", "distance": 10},
        {"name": "South City Kitchen", "distance": 13},
        {"name": "Busy Bee Cafe", "distance": 11},
      ],
      "Entertainment": [
        {"name": "Georgia Aquarium", "distance": 14},
        {"name": "World of Coca-Cola", "distance": 13},
        {"name": "Centennial Olympic Park", "distance": 12},
        {"name": "Fox Theatre", "distance": 13},
      ],
      "Shopping": [
        {"name": "Lenox Square Mall", "distance": 16},
        {"name": "Ponce City Market", "distance": 12},
        {"name": "Atlantic Station", "distance": 13},
        {"name": "Perimeter Mall", "distance": 20},
      ],
    },
    "Dallas-Fort Worth (DFW)": {
      "Restaurant": [
        {"name": "Pecan Lodge BBQ", "distance": 23},
        {"name": "Joe T. Garcia's", "distance": 17},
        {"name": "Velvet Taco", "distance": 18},
        {"name": "Truck Yard", "distance": 20},
      ],
      "Entertainment": [
        {"name": "AT&T Stadium", "distance": 15},
        {"name": "Sixth Floor Museum", "distance": 22},
        {"name": "Dallas Arboretum", "distance": 19},
        {"name": "Fort Worth Stockyards", "distance": 21},
      ],
      "Shopping": [
        {"name": "Galleria Dallas", "distance": 19},
        {"name": "NorthPark Center", "distance": 20},
        {"name": "Shops at Clearfork", "distance": 18},
        {"name": "Grapevine Mills", "distance": 8},
      ],
    },
  };

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

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
        .showSnackBar(SnackBar(content: Text('$place removed from favorites')));
  }

  void _showFavorites() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Your Favorites'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: _favorites.isEmpty
                ? [const Text("No favorites saved yet.")]
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
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  int _getDistanceLimit(double hours) {
    if (hours <= 3) return 10;
    if (hours <= 6) return 20;
    return 999;
  }

  void _getSuggestions() {
    final durationText = _durationController.text;
    if (durationText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your layover duration.")),
      );
      return;
    }

    final hours = double.tryParse(durationText) ?? 0;
    final distanceLimit = _getDistanceLimit(hours);
    final activities = cityActivities[_selectedAirport]?[widget.category];

    if (activities == null || activities.isEmpty) {
      setState(() {
        _suggestion =
            "No ${widget.category} activities found for $_selectedAirport.";
        _distanceNote = "";
      });
      return;
    }

    final filtered =
        activities.where((a) => (a["distance"] as int) <= distanceLimit).toList();

    if (filtered.isEmpty) {
      setState(() {
        _suggestion =
            "No ${widget.category} options within ${distanceLimit} miles of $_selectedAirport.";
        _distanceNote =
            "Showing places within $distanceLimit miles for a ${hours.toStringAsFixed(1)}-hour layover.";
      });
    } else {
      final random = Random();
      final chosen = filtered[random.nextInt(filtered.length)]["name"];
      setState(() {
        _suggestion =
            "Suggested ${widget.category} near $_selectedAirport: $chosen";
        _distanceNote =
            "Showing places within $distanceLimit miles for a ${hours.toStringAsFixed(1)}-hour layover.";
      });
    }

    _startCountdown(hours);
  }

  void _startCountdown(double hours) {
    _countdownTimer?.cancel();
    setState(() {
      _remainingTime = Duration(hours: hours.floor());
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds <= 0) {
        timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Layover time is up! Return to airport.")),
        );
      } else {
        setState(() {
          _remainingTime -= const Duration(seconds: 1);
        });
      }
    });
  }

  Future<void> _openDirections() async {
    if (_suggestion.isEmpty) return;

    final activity = _suggestion.split(": ").last;
    final query = Uri.encodeComponent(activity);
    final origin = Uri.encodeComponent(_selectedAirport);

    final url = Uri.parse(
      "https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$query",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Could not launch Google Maps")));
    }
  }

  // Fetch real-time flight info from AviationStack
  Future<void> _fetchFlightInfo() async {
    final flightCode = _flightController.text.trim();
    if (flightCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a flight code, e.g., AA123")),
      );
      return;
    }

    final apiKey = dotenv.env['AVIATIONSTACK_KEY'];
    print("🧩 Loaded API key: $apiKey");
    print("✈️ Fetching flight info for: $flightCode");

    // Try HTTPS first, fallback to HTTP
    final url = Uri.parse(
      'https://api.aviationstack.com/v1/flights?access_key=$apiKey&flight_iata=$flightCode',
    );

    print("🌍 Full request URL: $url");

    setState(() {
      _loadingFlight = true;
      _flightData = null;
    });

    try {
      final response = await http.get(url);
      print("📡 Response status: ${response.statusCode}");
      print("📦 Raw body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data'].isNotEmpty) {
          setState(() => _flightData = data['data'][0]);
          print("✅ Successfully loaded flight data!");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No flight data found.")),
          );
          print("⚠️ No flight data found in response.");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error ${response.statusCode}: ${response.reasonPhrase}")),
        );
        print("❌ HTTP Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch flight info: $e")),
      );
      print("💥 Exception: $e");
    } finally {
      setState(() => _loadingFlight = false);
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plan Your Layover: ${widget.category}"),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _durationController,
                    decoration: const InputDecoration(
                      labelText: "Layover Duration (hours)",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedAirport,
                    items: airports
                        .map((airport) => DropdownMenuItem(
                              value: airport,
                              child: Text(airport),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedAirport = value!;
                        _selectedAirportLoc =
                            airportLocations[_selectedAirport]!;
                        _suggestion = "";
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "Select Airport",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Check Flight Info",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _flightController,
                    decoration: const InputDecoration(
                      labelText: "Enter Flight Code (e.g., AA100)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _loadingFlight ? null : _fetchFlightInfo,
                    icon: const Icon(Icons.flight_takeoff),
                    label: const Text("Check Flight Status"),
                  ),
                  const SizedBox(height: 10),
                  if (_loadingFlight) const CircularProgressIndicator(),
                  if (_flightData != null) ...[
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 12),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Flight: ${_flightData!['flight']?['iata'] ?? 'N/A'}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text("Status: ${_flightData!['flight_status'] ?? 'Unknown'}"),
                            Text("Airline: ${_flightData!['airline']?['name'] ?? 'N/A'}"),
                            Text(
                              "Departure: ${_flightData!['departure']?['airport'] ?? 'N/A'} "
                              "at ${_flightData!['departure']?['estimated'] ?? 'N/A'}",
                            ),
                            Text(
                              "Arrival: ${_flightData!['arrival']?['airport'] ?? 'N/A'} "
                              "at ${_flightData!['arrival']?['estimated'] ?? 'N/A'}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _getSuggestions,
                    child: const Text("Get Suggestions"),
                  ),
                  const SizedBox(height: 10),
                  if (_distanceNote.isNotEmpty)
                    Text(
                      _distanceNote,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 24),
                  if (_suggestion.isNotEmpty) ...[
                    Text(
                      _suggestion,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _openDirections,
                      icon: const Icon(Icons.directions),
                      label: const Text("Get Directions"),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () => _saveFavorite(_suggestion),
                      icon: const Icon(Icons.star_border),
                      label: const Text("Save to Favorites"),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Opacity(
              opacity: 0.9,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
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
                    const SizedBox(height: 4),
                    Text(
                      _remainingTimeText,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

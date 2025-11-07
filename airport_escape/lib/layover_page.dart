import 'package:airport_escape/widgets/activities_list.dart';
import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widgets/search_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LayoverPage extends StatefulWidget {
  final String category; // passed from landing page

  const LayoverPage({super.key, required this.category});
  State<LayoverPage> createState() => _LayoverPageState();
}

class _LayoverPageState extends State<LayoverPage> {
  final _durationController = TextEditingController();
  String _selectedAirport = "";
  late LatLng _selectedAirportLoc;
  
  double _duration = 0;
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
    ).showSnackBar(SnackBar(content: Text('$place removed from favorites')));
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

  

  void _startCountdown(double hours) {
    _countdownTimer?.cancel();
    setState(() {
      _remainingTime = Duration(hours: hours.floor());
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds <= 0) {
        timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Layover time is up! Return to airport."),
          ),
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

  // Cross-platform API key loader (env or dart-define)
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
        const SnackBar(content: Text("Please enter a flight code, e.g., AA123")),
      );
      return;
    }

    final apiKey = _loadApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Missing API key. Provide with --dart-define or .env")),
      );
      return;
    }

    print("Loaded API key: $apiKey");
    print("Fetching flight info for: $flightCode");

    final url = Uri.parse(
      'https://api.aviationstack.com/v1/flights?access_key=$apiKey&flight_iata=$flightCode',
    );

    print("Full request URL: $url");

    setState(() {
      _loadingFlight = true;
      _flightData = null;
    });

    try {
      final response = await http.get(url);
      print("Response status: ${response.statusCode}");
      print("Raw body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data'].isNotEmpty) {
          setState(() => _flightData = data['data'][0]);
          print("Successfully loaded flight data!");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No flight data found.")),
          );
          print("No flight data found in response.");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error ${response.statusCode}: ${response.reasonPhrase}")),
        );
        print("HTTP Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch flight info: $e")),
      );
      print("Exception: $e");
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
        title: Text(
          AppLocalizations.of(context)!.plan_your_layover(widget.category),
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
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ], // Only numbers can be entered
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        _duration = double.parse(value);
                      });
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
                
                if (_selectedAirport.isNotEmpty && _duration > 0)
                  Expanded(
                    child: ActivitiesList(
                      key: ValueKey(_selectedAirport),
                      airportCords: _selectedAirportLoc,
                      duration: _duration,
                      category: widget.category,
                      onActivitiesChanged:(){
                        _startCountdown(_duration);
                      } ,
                      favorites: _favorites,
                      onFavorite: _saveFavorite,
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
                      "Return Timer",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _remainingTimeText,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
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

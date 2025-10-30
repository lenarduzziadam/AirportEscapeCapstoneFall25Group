import 'package:airport_escape/widgets/activities_list.dart';
import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widgets/search_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class LayoverPage extends StatefulWidget {
  final String category; // passed from landing page

  const LayoverPage({super.key, required this.category});
  @override
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
                      key: ValueKey("${_selectedAirport}_$_duration"),
                      airportCords: _selectedAirportLoc,
                      duration: _duration,
                      category: widget.category,
                      onActivitiesChanged:(){
                        _startCountdown(_duration);
                      } ,
                    ),
                  ),
              ],
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

import 'dart:convert';
import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:airport_escape/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:geolocator/geolocator.dart';

// returns the type name based on the category
List<String> _getTypeName(BuildContext context, String category) {
  List<String> types = [];
  if (category == AppLocalizations.of(context)!.restaurant) {
    types = ['restaurant'];
  } else if (category == AppLocalizations.of(context)!.shopping) {
    types = ['store'];
  } else if (category == AppLocalizations.of(context)!.entertainment) {
    types = [
      'movie_theater',
      'amusement_park',
      'aquarium',
      'museum',
      'night_club',
      'bowling_alley',
      'zoo',
      'stadium',
      'tourist_attraction',
      'casino',
      'art_gallery',
    ];
  }

  return types;
}

Future<List<dynamic>> _fetchNearbyActivities(
  BuildContext context,
  LatLng selectedAirportLoc,
  String category,
) async {
  final apiKey = dotenv.env['API_KEY'];
  final types = _getTypeName(context, category);
  if (types.isEmpty) {
    throw Exception('$category is not fully added');
  }

  List<dynamic> allResults = [];

  for (String type in types) {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?location=${selectedAirportLoc.latitude},${selectedAirportLoc.longitude}'
      '&radius=5000'
      '&type=$type'
      '&key=$apiKey',
    );

    final response = await http.get(url);
    final data = json.decode(response.body);

    if (data['status'] == 'OK' && data['results'] != null) {
      allResults.addAll(data['results']);
    }
  }

  final uniqueResults = {
    for (var r in allResults) r['place_id']: r,
  }.values.toList();

  return uniqueResults;
}

class ActivitiesList extends StatefulWidget {
  final LatLng airportCords;
  final String category;

  const ActivitiesList({
    super.key,
    required this.airportCords,
    required this.category,
  });

  @override
  ActivitiesListState createState() => ActivitiesListState();
}

class ActivitiesListState extends State<ActivitiesList> {
  late Future<List<dynamic>> _activities;
  Set<String> _favorites = {};



  @override
  void initState() {
    super.initState();
    _loadFavorites(); 
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList('favorites')?.toSet() ?? {};
    });
  }

  Future<void> _toggleFavorite(String destination) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favorites.contains(destination)) {
        _favorites.remove(destination);
      } else {
        _favorites.add(destination);
      }
      prefs.setStringList('favorites', _favorites.toList());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _activities = _fetchNearbyActivities(
      context,
      widget.airportCords,
      widget.category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<dynamic>>(
        future: _activities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: SelectableText('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No nearby activities found.'));
          }

          final activities = snapshot.data!;
          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              var activity = activities[index];
              var location = activity["geometry"]["location"];
              var activityLocation = LatLng(location["lat"], location["lng"]);
              double distanceInMeters = Geolocator.distanceBetween(
                widget.airportCords.latitude,
                widget.airportCords.longitude,
                activityLocation.latitude,
                activityLocation.longitude,
              );

              return Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: ListTile(
                      title: Text(activity["name"] ?? "Unknown Place"),
                      subtitle: Text(
                        activity["vicinity"] +
                                ' ${(distanceInMeters / 1000).toStringAsFixed(1)} km away' ??
                            "No address available",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              _favorites.contains(activity["name"])
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _favorites.contains(activity["name"]) ? Colors.red : null,
                            ),
                            onPressed: () => _toggleFavorite(activity["name"]),
                          ),
                          const Icon(Icons.place),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MapScreen(
                              startLocation: widget.airportCords,
                              endLocation: activityLocation,
                            );
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.directions, color: Colors.white),
                    label: Text(
                      AppLocalizations.of(context)!.get_directions,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

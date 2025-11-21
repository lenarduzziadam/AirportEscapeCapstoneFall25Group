import 'dart:convert';
import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:airport_escape/widgets/activity_suggestion_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

final double MILES_TO_METERS = 1609.344;

final double IS_IN_AIRPORT_DISTANCE = 600;

// returns the type name based on the category

class ActivitiesList extends StatefulWidget {
  final LatLng airportCords;
  final String category;
  final double duration;
  final Function() onActivitiesChanged;
  final bool isOnlyInAirport;

  final List<String> favorites;
  final Function(String) onFavorite;

  const ActivitiesList({
    super.key,
    required this.airportCords,
    required this.category,
    required this.duration,
    required this.onActivitiesChanged,
    required this.favorites,
    required this.onFavorite,
    required this.isOnlyInAirport,
  });

  @override
  ActivitiesListState createState() => ActivitiesListState();
}

class ActivitiesListState extends State<ActivitiesList> {
  late Future<List<dynamic>> _activities;
  String _distanceNote = "";

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

  int _getDistanceLimit(double hours) {
    if (hours <= 3) return 10;
    if (hours <= 6) return 20;
    return 999;
  }

  Future<List<dynamic>> _fetchNearbyActivities(
    BuildContext context,
    LatLng selectedAirportLoc,
    String category,
    double duration,
  ) async {
    final distanceLimit = widget.isOnlyInAirport
        ? IS_IN_AIRPORT_DISTANCE
        : _getDistanceLimit(duration) * MILES_TO_METERS;

    final apiKey = dotenv.env['GOOGLE_API_KEY'];
    final types = _getTypeName(context, category);
    if (types.isEmpty) {
      throw Exception('$category is not fully added');
    }

    List<dynamic> allResults = [];

    for (String type in types) {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=${selectedAirportLoc.latitude},${selectedAirportLoc.longitude}'
        '&radius=$distanceLimit'
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
    widget.onActivitiesChanged();
    return uniqueResults;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _activities = _fetchNearbyActivities(
      context,
      widget.airportCords,
      widget.category,
      widget.duration,
    );
    _distanceNote =
        "Showing places within ${widget.isOnlyInAirport ? IS_IN_AIRPORT_DISTANCE : _getDistanceLimit(widget.duration)} miles for a ${widget.duration.toStringAsFixed(1)}-hour layover.";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: _activities,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: SelectableText('Error: ${snapshot.error}'),
                );
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
                  var activityLocation = LatLng(
                    location["lat"],
                    location["lng"],
                  );
                  double distanceInMeters = Geolocator.distanceBetween(
                    widget.airportCords.latitude,
                    widget.airportCords.longitude,
                    activityLocation.latitude,
                    activityLocation.longitude,
                  );
                  return ActivitySuggestionBox(
                    activity: activity,
                    distanceInMeters: distanceInMeters,
                    airportCords: widget.airportCords,
                    activityLocation: activityLocation,
                    isFavorite: widget.favorites.contains(activity["name"]),
                    onFavorite: () => widget.onFavorite(activity["name"]),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

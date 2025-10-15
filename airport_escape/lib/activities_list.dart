import 'dart:convert';
import 'package:airport_escape/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'package:geolocator/geolocator.dart';

Future<List<dynamic>> fetchNearbyActivities(LatLng selectedAirportLoc) async {
  final apiKey = dotenv.env['API_KEY'];
  final url = Uri.parse(
    'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
    '?location=${selectedAirportLoc.latitude},${selectedAirportLoc.longitude}'
    '&radius=5000'
    '&type=tourist_attraction'
    '&key=$apiKey',
  );

  final response = await http.get(url);
  final data = json.decode(response.body);
  if (data['status'] != 'OK') {
    throw Exception('Places API error: ${data['status']}');
  }
  if (data['results'] == null) {
    throw Exception('Failed to load nearby activities');
  }

  final List<dynamic> results = data['results'];
  return results;
}

class ActivitiesList extends StatefulWidget {
  final LatLng airportCords;

  const ActivitiesList({super.key, required this.airportCords});

  @override
  ActivitiesListState createState() => ActivitiesListState();
}

class ActivitiesListState extends State<ActivitiesList> {
  late Future<List<dynamic>> _activities;

  @override
  void initState() {
    super.initState();
    _activities = fetchNearbyActivities(widget.airportCords);
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
                        activity["vicinity"] + ' ${(distanceInMeters / 1000).toStringAsFixed(1)} km away' ?? "No address available",
                      ),
                      trailing: Icon(Icons.place),
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
                    label: const Text(
                      "Get Directions",
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

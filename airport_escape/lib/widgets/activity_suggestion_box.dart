import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:airport_escape/main.dart';
import 'package:airport_escape/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<Image> _getPlaceImage(dynamic activity) async {
  final apiKey = dotenv.env['GOOGLE_API_KEY'];
  final photoRef = activity["photos"][0]["photo_reference"];
  var blankImage = Image.asset(
    'assets/images/placeholder.png',
    fit: BoxFit.cover,
  );
  if (photoRef == null) {
    // Return a default placeholder if no photo is available
    return blankImage;
  }

  final url = Uri.parse(
    'https://maps.googleapis.com/maps/api/place/photo'
    '?maxwidth=300'
    '&photo_reference=$photoRef'
    '&key=$apiKey',
  );
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return Image.memory(response.bodyBytes, fit: BoxFit.cover);
  } else {
    // Fallback image
    return blankImage;
  }
}

class ActivitySuggestionBox extends StatefulWidget {
  final dynamic activity;

  final double distanceInMeters;

  final LatLng airportCords;

  final LatLng activityLocation;

  const ActivitySuggestionBox({
    super.key,
    required this.activity,
    required this.distanceInMeters,
    required this.airportCords,
    required this.activityLocation,
  });

  @override
  ActivitySuggestionBoxState createState() => ActivitySuggestionBoxState();
}

class ActivitySuggestionBoxState extends State<ActivitySuggestionBox> {
  Image? _placeImage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlaceImage();
  }

  Future<void> _loadPlaceImage() async {
    try {
      final image = await _getPlaceImage(widget.activity);
      if (mounted) {
        setState(() {
          _placeImage = image;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: ListTile(
            title: Text(widget.activity["name"] ?? "Unknown Place"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.activity["vicinity"] ?? "No address"} • ${(widget.distanceInMeters / 1000).toStringAsFixed(1)} km away",
                ),
                if (widget.activity["rating"] != null)
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(widget.activity["rating"].toString()),
                    ],
                  ),
                if (widget.activity["opening_hours"]?["open_now"] != null)
                  Text(
                    widget.activity["opening_hours"]["open_now"]
                        ? "Open Now"
                        : "Closed",
                    style: TextStyle(
                      color: widget.activity["opening_hours"]["open_now"]
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
              ],
            ),
            trailing: Icon(Icons.place),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _isLoading
                  ? const SizedBox(
                      width: 60,
                      height: 60,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : _placeImage,
            ),
          ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MapScreen(
                    startLocation: widget.airportCords,
                    endLocation: widget.activityLocation,
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
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}



class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final LatLng _startLocation = const LatLng(43.77474504822277,11.261909855167868);

  final LatLng _endLocation = const LatLng(45.38002052011845, 12.342675855331597);

  final Set<Polyline> _polylines = {}; 


  List<LatLng> _decodePoly(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng point = LatLng(lat / 1E5, lng / 1E5);
      points.add(point);
    }

    print("Decoded ${points.length} polyline points.");
    return points;
  }

  void _getDirections() async {
    final String apiKeyFromFile = dotenv.env['API_KEY'] ?? "";

    const String mainApi =
        "https://maps.googleapis.com/maps/api/directions/json?origin=";
    final String startPosition =
        "${_startLocation.latitude},${_startLocation.longitude}";
    const String destination = "&destination=";
    final String endPosition =
        "${_endLocation.latitude},${_endLocation.longitude}";
    const String key = "&key=";
    String apiKey = apiKeyFromFile;

    final Uri uri = Uri.parse(
        mainApi + startPosition + destination + endPosition + key + apiKey);
    var response = await http.get(uri);

    Map data = json.decode(response.body);

    if (data['routes'].isEmpty) {
      print("No routes found");
      return;
    }

    String encodedString = data['routes'][0]['overview_polyline']['points'];
    List<LatLng> points = _decodePoly(encodedString);

    setState(() {
      _polylines.clear(); // optional: clear old routes
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route1'),
          visible: true,
          points: points,
          color: Colors.purple,
          width: 4,
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getDirections();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 18, 71, 156),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Maps Page'), elevation: 2),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _startLocation,
            zoom: 7.0,
          ),
          polylines: _polylines,
          markers: {
            Marker(
              markerId: const MarkerId("start"),
              position: _startLocation,
            ),
            Marker(
              markerId: const MarkerId("end"),
              position: _endLocation,
            )
          },
        ),
      ),
    );
  }
}

import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:airport_escape/widgets/flight_info_box.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlightStatusPage extends StatefulWidget {
  @override
  State<FlightStatusPage> createState() => _FlightStatusPageState();
}

class _FlightStatusPageState extends State<FlightStatusPage> {
  final _flightController = TextEditingController();
  bool _loadingFlight = false;
  Map<String, dynamic>? _flightData;
  // ======================= FLIGHT API =======================

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
        SnackBar(content: Text(AppLocalizations.of(context)!.enter_flight_code_snackbar)),
      );
      return;
    }

    final apiKey = _loadApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.missing_api_key_snackbar)));
      return;
    }

    final url = Uri.parse(
      'https://api.aviationstack.com/v1/flights?access_key=$apiKey&flight_iata=$flightCode',
    );

    setState(() {
      _loadingFlight = true;
      _flightData = null;
    });

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['data'] != null && data['data'].isNotEmpty) {
          setState(() => _flightData = data['data'][0]);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.no_flight_found_snackbar)));
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.check_flight_info_title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ----- Flight Input -----
                TextField(
                  controller: _flightController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.enter_flight_code_label,
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 8),

                ElevatedButton.icon(
                  onPressed: _loadingFlight ? null : _fetchFlightInfo,
                  icon: const Icon(Icons.flight_takeoff),
                  label: Text(AppLocalizations.of(context)!.check_status),
                ),
                if (_loadingFlight) const CircularProgressIndicator(),
                if (_flightData != null)
                  FlightInfoBox(flightData: _flightData!),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

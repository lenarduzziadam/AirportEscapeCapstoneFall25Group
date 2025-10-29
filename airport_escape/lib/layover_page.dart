import 'package:airport_escape/widgets/activities_list.dart';
import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'widgets/search_bar_widget.dart';

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
  int _duration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.plan_your_layover(widget.category),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.layover_duration_label,
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
                    _duration = int.parse(value);
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
              ActivitiesList(
                key: ValueKey(_selectedAirport),
                airportCords: _selectedAirportLoc,
                hoursInLayover: _duration,
                category: widget.category,
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:google_maps_flutter/google_maps_flutter.dart';

const _airportCords = LatLng(45.43824320692251, 10.991844909323326);
 
final Marker airportMarker = const Marker(
  markerId: MarkerId('airport'),
  position: _airportCords,
  infoWindow: InfoWindow(title: 'Verona'));
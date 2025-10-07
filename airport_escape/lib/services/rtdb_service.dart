import 'package:firebase_database/firebase_database.dart';

class RtdbService {
  final DatabaseReference _root = FirebaseDatabase.instance.ref();

  /// Live connection status from RTDB special path `.info/connected`
  Stream<bool> connection$() =>
      FirebaseDatabase.instance.ref('.info/connected').onValue.map(
        (e) => e.snapshot.value == true,
      );

  /// One-off developer ping you can call manually during dev
  Future<void> sendPing({String by = 'hugo', String msg = 'connected'}) async {
    await _root.child('debug/pings').push().set({
      'at': ServerValue.timestamp,
      'by': by,
      'msg': msg,
    });
  }
}

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

  /// Write a simple message into "messages"
  Future<void> writeMessage(String message, {String by = "hugo"}) async {
    await _root.child("messages").push().set({
      "text": message,
      "by": by,
      "at": ServerValue.timestamp,
    });
  }

  /// Read all messages once (not live updates)
  Future<List<String>> readMessages() async {
    final snapshot = await _root.child("messages").get();
    if (snapshot.exists) {
      final data = snapshot.value as Map;
      return data.values
          .map((e) => e["text"].toString())
          .toList();
    }
    return [];
  }

  /// Subscribe to live messages (updates automatically)
  Stream<List<String>> messages$() {
    return _root.child("messages").onValue.map((event) {
      if (event.snapshot.value != null) {
        final data = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>);
        return data.values
            .map((e) => e["text"].toString())
            .toList();
      }
      return <String>[];
    });
  }
}
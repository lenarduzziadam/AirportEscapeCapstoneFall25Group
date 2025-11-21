// lib/notification_test_page.dart

import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

// ------------------------
// Notification Service
// ------------------------
class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the plugin and create a channel for Android
  static Future<void> initialize() async {
    // Android initialization
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(initSettings);

    // Create a notification channel for Android
    const channel = AndroidNotificationChannel(
      'force_channel', // must match channel ID in AndroidNotificationDetails
      'Force Notifications',
      description: 'Channel for testing forced notifications',
      importance: Importance.max,
      playSound: true,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Request runtime notification permission (Android 13+)
  static Future<void> requestPermission() async {
    if (!kIsWeb) {
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }
    }
  }

  // Show an instant notification
  static Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    if (kIsWeb) {
      // Web fallback: show alert or console
      debugPrint('Web Notification - $title: $body');
      // You can optionally use JS interop for real browser notifications
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'force_channel',
      'Force Notifications',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
    );

    const details = NotificationDetails(android: androidDetails);

    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _plugin.show(id, title, body, details);
  }
}

// ------------------------
// Notification Test Page
// ------------------------
class NotificationTestPage extends StatefulWidget {
  const NotificationTestPage({super.key});

  @override
  State<NotificationTestPage> createState() => _NotificationTestPageState();
}

class _NotificationTestPageState extends State<NotificationTestPage> {
  Timer? _timer;
  int _secondsRemaining = 10;

  @override
  void initState() {
    super.initState();

    // Initialize notifications and request permission
    NotificationService.initialize().then((_) async {
      await NotificationService.requestPermission();
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 10;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsRemaining--;
      });

      if (_secondsRemaining <= 0) {
        timer.cancel();
        NotificationService.showInstantNotification(
          title: "Timer Done!",
          body: "Your countdown finished.",
        );
      }
    });
  }

  void _triggerInstantNotification() {
    NotificationService.showInstantNotification(
      title: "Hello!",
      body: "This is a manually triggered notification.",
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications & Timer Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startTimer,
              child: const Text("Start 10-Second Timer"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _triggerInstantNotification,
              child: const Text("Trigger Notification"),
            ),
            const SizedBox(height: 32),
            Text(
              "Timer: $_secondsRemaining seconds",
              style: const TextStyle(fontSize: 28),
            ),
          ],
        ),
      ),
    );
  }
}

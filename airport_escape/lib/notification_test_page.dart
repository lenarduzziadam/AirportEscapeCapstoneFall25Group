import 'dart:async';
import 'package:flutter/material.dart';

// Minimal fallback NotificationService to remove the broken import error.
// Replace this with your real implementation at lib/services/notification_service.dart when available.
class NotificationService {
  static void showInstantNotification({
    required String title,
    required String body,
  }) {
    // TODO: integrate with flutter_local_notifications or platform-specific notification code.
    // For now, log to the console so the app compiles and behavior is visible during testing.
    debugPrint('Notification - $title: $body');
  }
}

class NotificationTestPage extends StatefulWidget {
  const NotificationTestPage({super.key});

  @override
  State<NotificationTestPage> createState() => _NotificationTestPageState();
}

class _NotificationTestPageState extends State<NotificationTestPage> {
  Timer? _timer;
  int _secondsRemaining = 10; // default timer length

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 10;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsRemaining--;
      });

      if (_secondsRemaining <= 0) {
        timer.cancel();

        // 🔔 Send local notification when timer ends
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

            /// INSTANT NOTIFICATION BUTTON
            ElevatedButton(
              onPressed: _triggerInstantNotification,
              child: const Text("Trigger Notification"),
            ),

            const SizedBox(height: 32),

            /// TIMER DISPLAY
            Text(
              "Timer: $_secondsRemaining seconds",
              style: const TextStyle(fontSize: 28),
            ),

            const SizedBox(height: 20),

            /// START TIMER BUTTON
            ElevatedButton(
              onPressed: _startTimer,
              child: const Text("Start 10-Second Timer"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'notification_service.dart';

class NotificationTestPage extends StatelessWidget {
  const NotificationTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification Test")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            NotificationService.showNotification(
              title: "Test Notification",
              body: "This is a sample notification 🚀",
            );
          },
          child: const Text("Show Notification"),
        ),
      ),
    );
  }
}

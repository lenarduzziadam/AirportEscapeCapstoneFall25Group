// Flutter app entry point and theme setup
import 'package:flutter/material.dart';
// Import main landing page and widgets
import 'landing_page.dart';
// Import the notification service (Step 3)
import 'notification_service.dart';

// App-wide color constants
const kPrimaryColor = Color.fromARGB(255, 18, 71, 156);
const kBackgroundColor = Color(0xFFE0F7FA);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Step 4: Initialize notifications
  final notificationService = NotificationService();
  await notificationService.initNotifications();

  runApp(MyApp(notificationService: notificationService));
}

// Root widget: sets up MaterialApp and theme
class MyApp extends StatelessWidget {
  final NotificationService notificationService;

  const MyApp({super.key, required this.notificationService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Airport Escape, for passengers by passengers',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      home: MyHomePage(notificationService: notificationService), // 👈 modified
    );
  }
}

// Step 5: Example widget that uses notifications
class MyHomePage extends StatelessWidget {
  final NotificationService notificationService;

  const MyHomePage({super.key, required this.notificationService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Airport Escape")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            notificationService.showNotification(
              id: 0,
              title: "Welcome!",
              body: "This is a local notification 🚀",
            );
          },
          child: const Text("Show Notification"),
        ),
      ),
    );
  }
}

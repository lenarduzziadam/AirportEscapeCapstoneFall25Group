import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings =
        InitializationSettings(android: androidSettings);

    await _plugin.initialize(initializationSettings);
  }

  static Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    const android = AndroidNotificationDetails(
      'basic_channel',
      'Basic Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: android);

    await _plugin.show(0, title, body, details);
  }
}

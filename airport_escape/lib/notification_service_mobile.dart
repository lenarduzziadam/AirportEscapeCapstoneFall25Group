import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class _NotificationServiceImpl {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(initSettings);
    
    // Android channel setup
    const androidChannel = AndroidNotificationChannel(
      'basic_channel',
      'Basic Notifications',
      description: 'Used for important notifications',
      importance: Importance.high,
    );

    await _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidChannel);
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'basic_channel',
      'Basic Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    // Use a unique ID for each notification (milliseconds since epoch)
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _plugin.show(id, title, body, details);
  }
}

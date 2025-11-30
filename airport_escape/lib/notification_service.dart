import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServiceImpl {
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

    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _plugin.show(id, title, body, details);
  }
}

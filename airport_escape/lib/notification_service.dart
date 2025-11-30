import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // Call this from main.dart before runApp()
  static Future<void> initialize() async {
    // Timezone init
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: ios);

    await _plugin.initialize(settings);
  }

  // This is the function your timer calls
  static Future<void> scheduleNotificationInSeconds({required int seconds}) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    const NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'timer_channel',
        'Timer Notifications',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    final scheduledDate =
        tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds));

    await _plugin.zonedSchedule(
      id,
      'Timer Finished',
      'Your countdown is complete.',
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}

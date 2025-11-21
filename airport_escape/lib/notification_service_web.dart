import 'dart:html' as html;

class _NotificationServiceImpl {
  static Future<void> initialize() async {
    if (html.Notification.supported) {
      if (html.Notification.permission != 'granted') {
        await html.Notification.requestPermission();
      }
    }
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    if (!html.Notification.supported) return;

    if (html.Notification.permission == 'granted') {
      html.Notification(title, body: body);
    } else {
      final permission = await html.Notification.requestPermission();
      if (permission == 'granted') {
        html.Notification(title, body: body);
      }
    }
  }
}

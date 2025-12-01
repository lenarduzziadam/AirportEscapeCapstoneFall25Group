import 'dart:async';
import 'dart:ui';
import 'notification_service.dart'; // make sure this points to your working notification service

class TimerService {
  static final TimerService _instance = TimerService._internal();
  factory TimerService() => _instance;
  TimerService._internal();

  Timer? _timer;
  int _secondsLeft = 0;
  VoidCallback? onTick;

  void start({required int seconds, VoidCallback? tickCallback}) {
    _timer?.cancel();
    _secondsLeft = seconds;
    onTick = tickCallback;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft > 0) {
        _secondsLeft--;
        if (onTick != null) onTick!();
      } else {
        _timer?.cancel();
        NotificationServiceImpl.showNotification(
          title: 'Timer Finished',
          body: 'Your countdown is complete.',
        );
      }
    });
  }

  void cancel() {
    _timer?.cancel();
  }

  int get secondsLeft => _secondsLeft;
  bool get isRunning => _timer?.isActive ?? false;
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:airport_escape/notification_service.dart';

class SetTimerPage extends StatefulWidget {
  const SetTimerPage({super.key});

  @override
  State<SetTimerPage> createState() => _SetTimerPageState();
}

class _SetTimerPageState extends State<SetTimerPage> {
  int _secondsLeft = 10; // default for testing
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = 10); // reset timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        timer.cancel();
        // Timer finished → schedule local notification
        NotificationService.scheduleNotificationInSeconds(seconds: 1);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Time left: $_secondsLeft s', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _startTimer, child: const Text('Start Timer')),
          ],
        ),
      ),
    );
  }
}

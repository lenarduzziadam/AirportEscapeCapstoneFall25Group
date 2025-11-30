import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:airport_escape/notification_service.dart';
import 'package:airport_escape/timer_service.dart'; // <-- import your TimerService

class SetTimerPage extends StatefulWidget {
  const SetTimerPage({super.key});

  @override
  State<SetTimerPage> createState() => _SetTimerPageState();
}

class _SetTimerPageState extends State<SetTimerPage> {
  int _selectedHours = 0;
  int _selectedMinutes = 1;

  final timerService = TimerService();

  @override
  void initState() {
    super.initState();
    // Keep UI in sync if a timer is already running
    if (timerService.isRunning) {
      timerService.onTick = () => setState(() {});
    }
  }

  void _startTimer() {
    final totalSeconds = _selectedHours * 3600 + _selectedMinutes * 60;
    timerService.start(
      seconds: totalSeconds,
      tickCallback: () => setState(() {}),
    );
  }

  void _cancelTimer() {
    timerService.cancel();
    setState(() {});
  }

  String _formatTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:'
           '${minutes.toString().padLeft(2, '0')}:'
           '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timerService.onTick = null; // remove callback
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = timerService.isRunning;

    return Scaffold(
      appBar: AppBar(title: const Text('Set Timer')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isRunning)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 100,
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(initialItem: _selectedHours),
                    itemExtent: 32,
                    onSelectedItemChanged: (index) => setState(() => _selectedHours = index),
                    children: List.generate(24, (i) => Center(child: Text('$i h'))),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 150,
                  width: 100,
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(initialItem: _selectedMinutes),
                    itemExtent: 32,
                    onSelectedItemChanged: (index) => setState(() => _selectedMinutes = index),
                    children: List.generate(60, (i) => Center(child: Text('$i m'))),
                  ),
                ),
              ],
            )
          else
            Text(
              _formatTime(timerService.secondsLeft),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: isRunning ? null : _startTimer,
                child: Text(isRunning ? 'Running...' : 'Start Timer'),
              ),
              const SizedBox(width: 20),
              if (isRunning)
                ElevatedButton(
                  onPressed: _cancelTimer,
                  child: const Text('Cancel'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

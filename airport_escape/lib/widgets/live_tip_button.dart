import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LiveTipButton extends StatelessWidget {
  const LiveTipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Layover tip',
      icon: const Icon(Icons.tips_and_updates_outlined),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (_) => const _LiveTipSheet(),
        );
      },
    );
  }
}

class _LiveTipSheet extends StatelessWidget {
  const _LiveTipSheet();

  @override
  Widget build(BuildContext context) {
    final tipRef = FirebaseDatabase.instance.ref('announcements/tip');

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: StreamBuilder<DatabaseEvent>(
        stream: tipRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const _Loading();
          }
          final value = snapshot.data?.snapshot.value;
          if (value == null) {
            return const _Info(text: 'No tip yet.');
          }
          if (value is! Map) {
            return const _Info(text: 'Unexpected tip format.');
          }

          final map = Map<String, dynamic>.from(value);
          final text = (map['text'] ?? '').toString();
          final url = (map['url'] ?? '').toString();
          final updatedAtMs = int.tryParse('${map['updatedAt']}');
          final updatedAt = updatedAtMs != null
              ? DateTime.fromMillisecondsSinceEpoch(updatedAtMs)
              : null;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.tips_and_updates, size: 20),
                  const SizedBox(width: 8),
                  const Text('Layover Tip',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 12),
              Text(text.isNotEmpty ? text : 'Tip is empty.'),
              if (url.isNotEmpty) ...[
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => launchUrlString(url),
                  child: const Text('Open link'),
                ),
              ],
              if (updatedAt != null) ...[
                const SizedBox(height: 4),
                Text('Updated ${_relative(updatedAt)}',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _Info extends StatelessWidget {
  final String text;
  const _Info({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(child: Text(text)),
    );
  }
}

String _relative(DateTime t) {
  final d = DateTime.now().difference(t);
  if (d.inSeconds < 45) return 'just now';
  if (d.inMinutes < 60) return '${d.inMinutes}m ago';
  if (d.inHours < 24) return '${d.inHours}h ago';
  return '${d.inDays}d ago';
}

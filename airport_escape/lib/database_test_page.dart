import 'package:flutter/material.dart';
import 'services/rtdb_service.dart';

class DatabaseTestPage extends StatefulWidget {
  const DatabaseTestPage({super.key});

  @override
  State<DatabaseTestPage> createState() => _DatabaseTestPageState();
}

class _DatabaseTestPageState extends State<DatabaseTestPage> {
  final RtdbService _db = RtdbService();
  final TextEditingController _controller = TextEditingController();

  List<String> _messages = [];

  @override
  void initState() {
    super.initState();

    // Listen to live updates from RTDB
    _db.messages$().listen((msgs) {
      setState(() {
        _messages = msgs;
      });
    });
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;
    await _db.writeMessage(_controller.text.trim(), by: "hugo");
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RTDB Test Page")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Enter a message",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class User {
  final String username;
  final List<String> savedDestinations;

  User({required this.username, required this.savedDestinations});
}

class UserAccountWidget extends StatefulWidget {
  final String? destinationToSave; // Optional: pass a destination to save

  const UserAccountWidget({super.key, this.destinationToSave});

  @override
  State<UserAccountWidget> createState() => _UserAccountWidgetState();
}

class _UserAccountWidgetState extends State<UserAccountWidget> {
  User? _user;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  void _login() {
    setState(() {
      _user = User(username: _usernameController.text, savedDestinations: []);
      // Save the destination if passed
      if (widget.destinationToSave != null) {
        _user!.savedDestinations.add(widget.destinationToSave!);
      }
    });
  }

  void _saveDestination(String destination) {
    setState(() {
      if (destination.isNotEmpty && !_user!.savedDestinations.contains(destination)) {
        _user?.savedDestinations.add(destination);
      }
      _destinationController.clear();
    });
  }

  void _removeDestination(String destination) {
    setState(() {
      _user?.savedDestinations.remove(destination);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Column(
        children: [
          const Text('Login to see and save your destinations'),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          ElevatedButton(
            onPressed: _login,
            child: const Text('Login'),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome, ${_user!.username}!'),
          const SizedBox(height: 8),
          const Text('Your saved destinations:'),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _destinationController,
                  decoration: const InputDecoration(
                    hintText: 'Enter destination name',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _saveDestination(_destinationController.text),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Your saved destinations:'),
          ..._user!.savedDestinations.map(
            (dest) => ListTile(
              title: Text(dest),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _removeDestination(dest),
              ),
            ),
          ),
        ],
      );
    }
  }
}
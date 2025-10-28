import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String username;
  final List<String> savedDestinations;

  User({required this.username, required this.savedDestinations});
}

class UserAccountWidget extends StatefulWidget {
  final String? username;
  final String? destinationToSave; // Optional: pass a destination to save

  const UserAccountWidget({super.key, this.username, this.destinationToSave});

  @override
  State<UserAccountWidget> createState() => _UserAccountWidgetState();
}

class _UserAccountWidgetState extends State<UserAccountWidget> {
  User? _user;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLoggedInUser();
  }

  Future<void> _loadLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('logged_in_user');
    if (username != null) {
      setState(() {
        _user = User(username: username, savedDestinations: []);
      });
    }
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username and password required')),
      );
      return;
    }

    // Demo: require password to be "password123"
    if (password != "password123") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect password')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('logged_in_user', username);

    setState(() {
      _user = User(username: username, savedDestinations: []);
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
  return Scaffold(
    appBar: AppBar(
      title: Text(_user == null ? 'Login' : 'Account'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: _user == null
            ? Column(
                children: [
                  const Text('Login to see and save your destinations'),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ],
              )
            : Column(
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
              ),
        ),
      ),
    );
  }
}
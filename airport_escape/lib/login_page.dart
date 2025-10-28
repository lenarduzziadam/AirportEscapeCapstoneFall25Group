import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_account.dart'; // Create this page if you don't have it

class LoginPage extends StatefulWidget {
  final void Function(String username) onLogin;

  const LoginPage({super.key, required this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleLogin() async {
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

    // Save login state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('logged_in_user', username);

    widget.onLogin(username);

    // Navigate to AccountPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserAccountWidget(username: username)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login to your account', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

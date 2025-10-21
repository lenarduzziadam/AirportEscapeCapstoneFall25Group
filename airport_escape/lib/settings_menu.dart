import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; 
import 'settings/theme_toggle.dart'; 

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Settings state variables
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  double _brightness = 0.8;
  String _selectedLanguage = 'English';
  bool _autoRefresh = true;
  bool _saveSearchHistory = true;

  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
    'العربية (Arabic)', // Arabic
    'Русский (Russian)', // Russian
    '한국어 (Korean)', // Korean
    '日本語 (Japanese)', // Japanese
    '中文 (Chinese)', // Chinese
    'हिन्दी (Hindi)', // Hindi
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).primaryColor, 
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // General Section
          _buildSectionHeader('General'),
          _buildSwitchTile(
            title: 'Dark Mode',
            subtitle: 'Enable dark theme',
            value: context.watch<ThemeProvider>().isDarkMode, // use provider
            icon: Icons.dark_mode,
            onChanged: (value) {
              context.read<ThemeProvider>().setDarkMode(value); // set via provider
              _showSnackBar('Dark mode ${value ? 'enabled' : 'disabled'}');
            },
          ),
          _buildBrightnessTile(),
          _buildLanguageDropdown(),
          
          const SizedBox(height: 20),
          
          // Notifications Section
          _buildSectionHeader('Notifications'),
          _buildSwitchTile(
            title: 'Push Notifications',
            subtitle: 'Receive layover suggestions and updates',
            value: _notificationsEnabled,
            icon: Icons.notifications,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
              _showSnackBar('Notifications ${value ? 'enabled' : 'disabled'}');
            },
          ),
          
          const SizedBox(height: 20),
          
          // Privacy Section
          _buildSectionHeader('Privacy & Data'),
          _buildSwitchTile(
            title: 'Location Services',
            subtitle: 'Allow app to access your location',
            value: _locationEnabled,
            icon: Icons.location_on,
            onChanged: (value) {
              setState(() {
                _locationEnabled = value;
              });
              _showSnackBar('Location ${value ? 'enabled' : 'disabled'}');
            },
          ),
          _buildSwitchTile(
            title: 'Save Search History',
            subtitle: 'Remember your recent searches',
            value: _saveSearchHistory,
            icon: Icons.history,
            onChanged: (value) {
              setState(() {
                _saveSearchHistory = value;
              });
              _showSnackBar('Search history ${value ? 'enabled' : 'disabled'}');
            },
          ),
          
          const SizedBox(height: 20),
          
          // App Behavior Section
          _buildSectionHeader('App Behavior'),
          _buildSwitchTile(
            title: 'Auto Refresh',
            subtitle: 'Automatically refresh activity suggestions',
            value: _autoRefresh,
            icon: Icons.refresh,
            onChanged: (value) {
              setState(() {
                _autoRefresh = value;
              });
              _showSnackBar('Auto refresh ${value ? 'enabled' : 'disabled'}');
            },
          ),
          
          const SizedBox(height: 20),
          
          // About Section
          _buildSectionHeader('About'),
          _buildInfoTile(
            title: 'Version',
            subtitle: '0.4.2',
            icon: Icons.info,
            onTap: () => _showVersionDialog(),
          ),
          _buildInfoTile(
            title: 'Privacy Policy',
            subtitle: 'View our privacy policy',
            icon: Icons.privacy_tip,
            onTap: () => _showPrivacyPolicy(),
          ),
          _buildInfoTile(
            title: 'Terms of Service',
            subtitle: 'View terms and conditions',
            icon: Icons.description,
            onTap: () => _showTermsOfService(),
          ),
          
          const SizedBox(height: 20),
          
          // Reset Section
          _buildSectionHeader('Reset'),
          _buildDangerTile(
            title: 'Clear All Data',
            subtitle: 'Reset app to default settings',
            icon: Icons.delete_forever,
            onTap: () => _showResetDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        secondary: Icon(icon),
      ),
    );
  }

  Widget _buildBrightnessTile() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.brightness_6),
        title: const Text('Brightness'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Adjust screen brightness: ${(_brightness * 100).round()}%'),
            Slider(
              value: _brightness,
              onChanged: (value) {
                setState(() {
                  _brightness = value;
                });
                // Provide haptic feedback
                HapticFeedback.selectionClick();
              },
              divisions: 10,
              label: '${(_brightness * 100).round()}%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.language),
        title: const Text('Language'),
        subtitle: DropdownButton<String>(
          value: _selectedLanguage,
          isExpanded: true,
          underline: const SizedBox(),
          items: _languages.map((String language) {
            return DropdownMenuItem<String>(
              value: language,
              child: Text(language),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedLanguage = newValue;
              });
              _showSnackBar('Language changed to $newValue');
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildDangerTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(title, style: const TextStyle(color: Colors.red)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right, color: Colors.red),
        onTap: onTap,
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showVersionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Airport Escape'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Version: 0.4.2'),
              Text('Build: 2025.10.15'),
              SizedBox(height: 16),
              Text('Developed by Team Airport Escape'),
              Text('© 2025 All rights reserved'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: const SingleChildScrollView(
            child: Text(
              'Airport Escape Privacy Policy\n\n'
              'We collect location data to provide personalized layover suggestions. '
              'Your data is stored locally and never shared with third parties without consent.\n\n'
              'For full privacy policy, visit our website.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showTermsOfService() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms of Service'),
          content: const SingleChildScrollView(
            child: Text(
              'Airport Escape Terms of Service\n\n'
              'By using this app, you agree to our terms and conditions. '
              'The app provides suggestions for entertainment during layovers. '
              'We are not responsible for any issues that may arise from following our suggestions.\n\n'
              'For full terms, visit our website.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset All Settings'),
          content: const Text(
            'This will reset all settings to their default values. '
            'This action cannot be undone. Are you sure?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _notificationsEnabled = true;
                  _locationEnabled = true;
                  _brightness = 0.8;
                  _selectedLanguage = 'English';
                  _autoRefresh = true;
                  _saveSearchHistory = true;
                });
                // Reset theme to light
                context.read<ThemeProvider>().setDarkMode(false);
                Navigator.of(context).pop();
                _showSnackBar('All settings reset to defaults');
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}
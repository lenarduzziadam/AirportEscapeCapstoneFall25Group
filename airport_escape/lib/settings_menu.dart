import 'package:airport_escape/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; 
import 'settings/locale_provider.dart';
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
        title: Text(AppLocalizations.of(context)!.settings),
        backgroundColor: Theme.of(context).primaryColor, 
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // General Section
          _buildSectionHeader(AppLocalizations.of(context)!.general_settings),
          _buildSwitchTile(
            title: AppLocalizations.of(context)!.dark_mode,
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
          _buildSectionHeader(AppLocalizations.of(context)!.section_notifications),
          _buildSwitchTile(
            title: AppLocalizations.of(context)!.notifications,
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
          _buildSectionHeader(AppLocalizations.of(context)!.section_privacy_and_data),
          _buildSwitchTile(
            title: AppLocalizations.of(context)!.location_services,
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
            title: AppLocalizations.of(context)!.save_search_history,
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
          _buildSectionHeader(AppLocalizations.of(context)!.section_app_behavior),
          _buildSwitchTile(
            title: AppLocalizations.of(context)!.auto_refresh,
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
          _buildSectionHeader(AppLocalizations.of(context)!.section_about),
          _buildInfoTile(
            title: AppLocalizations.of(context)!.version,
            subtitle: '0.4.2',
            icon: Icons.info,
            onTap: () => _showVersionDialog(),
          ),
          _buildInfoTile(
            title: AppLocalizations.of(context)!.privacy_policy,
            subtitle: 'View our privacy policy',
            icon: Icons.privacy_tip,
            onTap: () => _showPrivacyPolicy(),
          ),
          _buildInfoTile(
            title: AppLocalizations.of(context)!.terms_of_service,
            subtitle: 'View terms and conditions',
            icon: Icons.description,
            onTap: () => _showTermsOfService(),
          ),
          
          const SizedBox(height: 20),
          
          // Reset Section
          _buildSectionHeader(AppLocalizations.of(context)!.section_reset),
          _buildDangerTile(
            title: AppLocalizations.of(context)!.reset_all_settings,
            subtitle: 'Reset app to default settings',
            icon: Icons.delete_forever,
            onTap: () => _showResetDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    final theme = Theme.of(context);
    final headerColor = theme.colorScheme.onSurface.withOpacity(0.70);

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: headerColor,
            ) ??
            TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: headerColor,
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
        title: Text(AppLocalizations.of(context)!.brightness),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.adjust_screen_brightness('${(_brightness * 100).round()}')),
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
              label: '${(_brightness * 100).round()}',
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
        title: Text(AppLocalizations.of(context)!.language),
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

              // Map displayed language to a Locale and notify provider
              final locale = _localeFromLanguage(newValue);
              context.read<LocaleProvider>().setLocale(locale);

              _showSnackBar('Language changed to $newValue');
            }
          },
        ),
      ),
    );
  }

  // helper to map display string to the correct locale
  Locale _localeFromLanguage(String language) {
    switch (language) {
      case 'العربية (Arabic)':
      case 'العربية':
        return const Locale('ar');
      case 'Русский (Russian)':
      case 'Русский':
        return const Locale('ru');
      case '한국어 (Korean)':
      case '한국어':
        return const Locale('ko');
      case '日本語 (Japanese)':
      case '日本語':
        return const Locale('ja');
      case '中文 (Chinese)':
      case '中文':
        return const Locale('zh');
      case 'हिन्दी (Hindi)':
      case 'हिन्दी':
        return const Locale('hi');
      case 'Spanish':
        return const Locale('es');
      case 'French':
        return const Locale('fr');
      case 'German':
        return const Locale('de');
      case 'Italian':
        return const Locale('it');
      default:
        return const Locale('en');
    }
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
          title: Text(AppLocalizations.of(context)!.airport_escape),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.version_info),
              const SizedBox(height: 16),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.ok),
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
          title: Text(AppLocalizations.of(context)!.privacy_policy),
          content: SingleChildScrollView(
            child: Text(
              AppLocalizations.of(context)!.privacy_policy_content,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.close),
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
          title: Text(AppLocalizations.of(context)!.terms_of_service),
          content: SingleChildScrollView(
            child: Text(
              //added localization here (just added so making todo comment for tracking purposes)
              AppLocalizations.of(context)!.terms_of_service_content,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.close),
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
          title: Text(AppLocalizations.of(context)!.reset_all_settings),
          content: Text(
            'This will reset all settings to their default values. '
            'This action cannot be undone. Are you sure?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancel),
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
              child: Text(AppLocalizations.of(context)!.section_reset),
            ),
          ],
        );
      },
    );
  }
}
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
  // Settings toggles
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _autoRefresh = true;
  bool _saveSearchHistory = true;

  double _brightness = 0.8;
  String _selectedLanguage = 'English';

  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
    'العربية (Arabic)',
    'Русский (Russian)',
    '한국어 (Korean)',
    '日本語 (Japanese)',
    '中文 (Chinese)',
    'हिन्दी (Hindi)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ===================== GENERAL SECTION =====================
          _buildSectionHeader(AppLocalizations.of(context)!.general_settings),

          _buildSwitchTile(
            title: AppLocalizations.of(context)!.dark_mode,
            subtitle: AppLocalizations.of(context)!.enable_dark_theme_subtitle,
            value: context.watch<ThemeProvider>().isDarkMode,
            icon: Icons.dark_mode,
            onChanged: (value) {
              context.read<ThemeProvider>().setDarkMode(value);
              _showSnackBar(
                  'Dark mode ${value ? "enabled" : "disabled"}');
            },
          ),

          _buildBrightnessTile(),
          _buildLanguageDropdown(),

          const SizedBox(height: 20),

          // ===================== NOTIFICATIONS SECTION =====================
          _buildSectionHeader(
              AppLocalizations.of(context)!.section_notifications),

          _buildSwitchTile(
            title: AppLocalizations.of(context)!.notifications,
            subtitle:
                AppLocalizations.of(context)!.receive_suggestions_subtitle,
            value: _notificationsEnabled,
            icon: Icons.notifications,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
              _showSnackBar(
                  'Notifications ${value ? "enabled" : "disabled"}');
            },
          ),

          const SizedBox(height: 20),

          // ===================== PRIVACY SECTION =====================
          _buildSectionHeader(
              AppLocalizations.of(context)!.section_privacy_and_data),

          _buildSwitchTile(
            title: AppLocalizations.of(context)!.location_services,
            subtitle: AppLocalizations.of(context)!.allow_location_subtitle,
            value: _locationEnabled,
            icon: Icons.location_on,
            onChanged: (value) {
              setState(() => _locationEnabled = value);
              _showSnackBar(
                  'Location ${value ? "enabled" : "disabled"}');
            },
          ),

          _buildSwitchTile(
            title: AppLocalizations.of(context)!.save_search_history,
            subtitle: AppLocalizations.of(context)!.remember_searches_subtitle,
            value: _saveSearchHistory,
            icon: Icons.history,
            onChanged: (value) {
              setState(() => _saveSearchHistory = value);
              _showSnackBar(
                  'Search history ${value ? "enabled" : "disabled"}');
            },
          ),

          const SizedBox(height: 20),

          // ===================== APP BEHAVIOR SECTION =====================
          _buildSectionHeader(
              AppLocalizations.of(context)!.section_app_behavior),

          _buildSwitchTile(
            title: AppLocalizations.of(context)!.auto_refresh,
            subtitle: AppLocalizations.of(context)!.auto_refresh_subtitle,
            value: _autoRefresh,
            icon: Icons.refresh,
            onChanged: (value) {
              setState(() => _autoRefresh = value);
              _showSnackBar(
                  'Auto refresh ${value ? "enabled" : "disabled"}');
            },
          ),

          const SizedBox(height: 20),

          // ===================== ABOUT SECTION =====================
          _buildSectionHeader(AppLocalizations.of(context)!.section_about),

          _buildInfoTile(
            title: AppLocalizations.of(context)!.version,
            subtitle: "0.4.2",
            icon: Icons.info,
            onTap: () => _showVersionDialog(),
          ),

          _buildInfoTile(
            title: AppLocalizations.of(context)!.privacy_policy,
            subtitle:
                AppLocalizations.of(context)!.view_privacy_policy_subtitle,
            icon: Icons.privacy_tip,
            onTap: () => _showPrivacyPolicy(),
          ),

          _buildInfoTile(
            title: AppLocalizations.of(context)!.terms_of_service,
            subtitle: AppLocalizations.of(context)!.view_terms_subtitle,
            icon: Icons.description,
            onTap: () => _showTermsOfService(),
          ),

          const SizedBox(height: 20),

          // ===================== RESET SECTION =====================
          _buildSectionHeader(AppLocalizations.of(context)!.section_reset),

          _buildDangerTile(
            title: AppLocalizations.of(context)!.reset_all_settings,
            subtitle: AppLocalizations.of(context)!.reset_app_subtitle,
            icon: Icons.delete_forever,
            onTap: () => _showResetDialog(),
          ),
        ],
      ),
    );
  }

  // =================================================================
  // SECTION HEADER
  // =================================================================
  Widget _buildSectionHeader(String title) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
    );
  }

  // =================================================================
  // SWITCH TILE
  // =================================================================
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

  // =================================================================
  // BRIGHTNESS TILE (FIXED)
  // =================================================================
  Widget _buildBrightnessTile() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.brightness_6),
        title: Text(AppLocalizations.of(context)!.brightness),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.adjust_screen_brightness(
                (_brightness * 100).round(),
              ),
            ),
            Slider(
              value: _brightness,
              onChanged: (value) {
                setState(() => _brightness = value);
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

  // =================================================================
  // LANGUAGE DROPDOWN
  // =================================================================
  Widget _buildLanguageDropdown() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.language),
        title: Text(AppLocalizations.of(context)!.language),
        subtitle: DropdownButton<String>(
          isExpanded: true,
          value: _selectedLanguage,
          underline: const SizedBox(),
          items: _languages.map((language) {
            return DropdownMenuItem(
              value: language,
              child: Text(language),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedLanguage = value);
              context
                  .read<LocaleProvider>()
                  .setLocale(_localeFromLanguage(value));
              _showSnackBar('Language changed to $value');
            }
          },
        ),
      ),
    );
  }

  Locale _localeFromLanguage(String language) {
    switch (language) {
      case 'العربية (Arabic)':
        return const Locale('ar');
      case 'Русский (Russian)':
        return const Locale('ru');
      case '한국어 (Korean)':
        return const Locale('ko');
      case '日本語 (Japanese)':
        return const Locale('ja');
      case '中文 (Chinese)':
        return const Locale('zh');
      case 'हिन्दी (Hindi)':
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

  // =================================================================
  // INFO TILE
  // =================================================================
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

  // =================================================================
  // DANGER TILE
  // =================================================================
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
        trailing:
            const Icon(Icons.chevron_right, color: Colors.red),
        onTap: onTap,
      ),
    );
  }

  // =================================================================
  // SNACKBAR
  // =================================================================
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // =================================================================
  // VERSION POPUP
  // =================================================================
  void _showVersionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.airport_escape),
        content: Text(AppLocalizations.of(context)!.version_info),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  // =================================================================
  // PRIVACY POLICY POPUP
  // =================================================================
  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.privacy_policy),
        content: SingleChildScrollView(
          child: Text(AppLocalizations.of(context)!.privacy_policy_content),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.close),
          ),
        ],
      ),
    );
  }

  // =================================================================
  // TERMS OF SERVICE POPUP
  // =================================================================
  void _showTermsOfService() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.terms_of_service),
        content: SingleChildScrollView(
          child:
              Text(AppLocalizations.of(context)!.terms_of_service_content),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.close),
          ),
        ],
      ),
    );
  }

  // =================================================================
  // RESET SETTINGS POPUP
  // =================================================================
  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.reset_all_settings),
        content: Text(AppLocalizations.of(context)!.reset_dialog_content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _notificationsEnabled = true;
                _locationEnabled = true;
                _autoRefresh = true;
                _saveSearchHistory = true;
                _brightness = 0.8;
                _selectedLanguage = 'English';
              });

              context.read<ThemeProvider>().setDarkMode(false);

              Navigator.pop(context);
              _showSnackBar(
                AppLocalizations.of(context)!.reset_success_snackbar,
              );
            },
            child: Text(
              AppLocalizations.of(context)!.reset_confirm_button,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

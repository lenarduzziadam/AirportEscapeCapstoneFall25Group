// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get dark_mode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get notifications => 'Push Notifications';

  @override
  String get location_services => 'Location Services';

  @override
  String get brightness => 'Brightness';

  @override
  String get reset_all_settings => 'Reset All Settings';

  @override
  String get welcome_message => 'Welcome to Airport Escape!';

  @override
  String get restaurant => 'Restaurant';

  @override
  String get entertainment => 'Entertainment';

  @override
  String get shopping => 'Shopping';

  @override
  String get profile => 'Profile';

  @override
  String get logout => 'Logout';

  @override
  String get security => 'Security';

  @override
  String get general_settings => 'General Settings';

  @override
  String get airport_escape => 'Airport Escape';

  @override
  String plan_your_layover(Object category) {
    return 'Plan Your Layover: $category';
  }

  @override
  String get layover_duration_label => 'Layover Duration (hours)';

  @override
  String get select_airport => 'Select Airport';

  @override
  String get please_enter_duration => 'Please enter your layover duration.';

  @override
  String get could_not_launch_maps => 'Could not launch Google Maps';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return 'Suggested activity near $airport: $activity';
  }
}

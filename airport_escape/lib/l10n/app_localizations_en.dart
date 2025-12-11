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
  String get plan_your_layover => 'Plan Your Layover';

  @override
  String get layover_duration_label => 'Layover Duration (hours)';

  @override
  String get select_airport => 'Select an airport';

  @override
  String get please_enter_duration => 'Please enter your layover duration.';

  @override
  String get could_not_launch_maps => 'Could not launch Google Maps';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return 'Suggested activity near $airport: $activity';
  }

  @override
  String get get_directions => 'Get Directions';

  @override
  String get save_search_history => 'Save search history';

  @override
  String get auto_refresh => 'Auto refresh';

  @override
  String get privacy_policy => 'Privacy Policy';

  @override
  String get terms_of_service => 'Terms of Service';

  @override
  String get section_privacy_and_data => 'Privacy & Data';

  @override
  String get section_notifications => 'Notifications';

  @override
  String get section_app_behavior => 'App Behavior';

  @override
  String get section_about => 'About';

  @override
  String get section_reset => 'Reset';

  @override
  String get section_general => 'General';

  @override
  String get version => 'Version';

  @override
  String get version_info =>
      'Version: 0.4.7\nBuild: 2025.10.20\nDeveloped by Team Airport Escape\n© 2025 All rights reserved';

  @override
  String get privacy_policy_content =>
      'We collect location data to provide personalized layover suggestions.\n\nData is stored locally and not shared without consent.\n\nFor full policy, visit our website.';

  @override
  String get terms_of_service_content =>
      'By using this app you agree to our terms.\n\nThe app provides suggestions for entertainment during layovers.\n\nWe are not responsible for issues resulting from following suggestions.\n\nFor full terms, visit our website.';

  @override
  String get about_content =>
      'Airport Escape helps passengers plan activities during layovers.\n\nBuilt by Team Airport Escape.\n\n© 2025 Team Airport Escape.';

  @override
  String get ok => 'OK';

  @override
  String get close => 'Close';

  @override
  String get cancel => 'Cancel';

  @override
  String adjust_screen_brightness(Object percent) {
    return 'Adjust screen brightness: $percent%';
  }

  @override
  String get enable_dark_theme_subtitle => 'Enable dark theme';

  @override
  String get receive_suggestions_subtitle =>
      'Receive layover suggestions and updates';

  @override
  String get allow_location_subtitle => 'Allow app to access your location';

  @override
  String get remember_searches_subtitle => 'Remember your recent searches';

  @override
  String get auto_refresh_subtitle =>
      'Automatically refresh activity suggestions';

  @override
  String get view_privacy_policy_subtitle => 'View our privacy policy';

  @override
  String get view_terms_subtitle => 'View terms and conditions';

  @override
  String get reset_app_subtitle => 'Reset app to default settings';

  @override
  String get reset_dialog_content =>
      'This will reset all settings to their default values.\n\nThis action cannot be undone. Are you sure?';

  @override
  String get reset_confirm_button => 'Reset';

  @override
  String get reset_success_snackbar => 'All settings reset to defaults';

  @override
  String get signIn => 'Sign In';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get enterPassword => 'Enter Password';

  @override
  String get signInTitle => 'Sign In to Airport Escape';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signInButton => 'Sign In';

  @override
  String get registerButton => 'Create Account';

  @override
  String get loggingIn => 'Signing in...';

  @override
  String get creatingAccount => 'Creating account...';

  @override
  String get authError => 'Authentication Error';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get joinAirportEscape => 'Join Airport Escape';

  @override
  String get check_flight_info => 'Check Flight Info';

  @override
  String get set_timer => 'Set Timer';

  @override
  String get category => 'Category';

  @override
  String get check_flight_info_title => 'Check Flight Info';

  @override
  String get enter_flight_code_label => 'Enter Flight Code (e.g. AA100)';

  @override
  String get check_status => 'Check Status';

  @override
  String get enter_flight_code_snackbar => 'Enter a flight code (e.g. AA100)';

  @override
  String get missing_api_key_snackbar => 'Missing API key!';

  @override
  String get no_flight_found_snackbar => 'No flight found.';

  @override
  String get error_snackbar => 'Error';
}

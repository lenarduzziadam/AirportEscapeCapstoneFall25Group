import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get notifications;

  /// No description provided for @location_services.
  ///
  /// In en, this message translates to:
  /// **'Location Services'**
  String get location_services;

  /// No description provided for @brightness.
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get brightness;

  /// No description provided for @reset_all_settings.
  ///
  /// In en, this message translates to:
  /// **'Reset All Settings'**
  String get reset_all_settings;

  /// No description provided for @welcome_message.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Airport Escape!'**
  String get welcome_message;

  /// No description provided for @restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get restaurant;

  /// No description provided for @entertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainment;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @general_settings.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get general_settings;

  /// No description provided for @airport_escape.
  ///
  /// In en, this message translates to:
  /// **'Airport Escape'**
  String get airport_escape;

  /// No description provided for @plan_your_layover.
  ///
  /// In en, this message translates to:
  /// **'Plan Your Layover'**
  String get plan_your_layover;

  /// No description provided for @layover_duration_label.
  ///
  /// In en, this message translates to:
  /// **'Layover Duration (hours)'**
  String get layover_duration_label;

  /// No description provided for @select_airport.
  ///
  /// In en, this message translates to:
  /// **'Select an airport'**
  String get select_airport;

  /// No description provided for @please_enter_duration.
  ///
  /// In en, this message translates to:
  /// **'Please enter your layover duration.'**
  String get please_enter_duration;

  /// No description provided for @could_not_launch_maps.
  ///
  /// In en, this message translates to:
  /// **'Could not launch Google Maps'**
  String get could_not_launch_maps;

  /// No description provided for @suggested_activity_near.
  ///
  /// In en, this message translates to:
  /// **'Suggested activity near {airport}: {activity}'**
  String suggested_activity_near(Object activity, Object airport);

  /// No description provided for @get_directions.
  ///
  /// In en, this message translates to:
  /// **'Get Directions'**
  String get get_directions;

  /// No description provided for @save_search_history.
  ///
  /// In en, this message translates to:
  /// **'Save search history'**
  String get save_search_history;

  /// No description provided for @auto_refresh.
  ///
  /// In en, this message translates to:
  /// **'Auto refresh'**
  String get auto_refresh;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @terms_of_service.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms_of_service;

  /// No description provided for @section_privacy_and_data.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Data'**
  String get section_privacy_and_data;

  /// No description provided for @section_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get section_notifications;

  /// No description provided for @section_app_behavior.
  ///
  /// In en, this message translates to:
  /// **'App Behavior'**
  String get section_app_behavior;

  /// No description provided for @section_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get section_about;

  /// No description provided for @section_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get section_reset;

  /// No description provided for @section_general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get section_general;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @version_info.
  ///
  /// In en, this message translates to:
  /// **'Version: 0.4.7\nBuild: 2025.10.20\nDeveloped by Team Airport Escape\n© 2025 All rights reserved'**
  String get version_info;

  /// No description provided for @privacy_policy_content.
  ///
  /// In en, this message translates to:
  /// **'We collect location data to provide personalized layover suggestions.\n\nData is stored locally and not shared without consent.\n\nFor full policy, visit our website.'**
  String get privacy_policy_content;

  /// No description provided for @terms_of_service_content.
  ///
  /// In en, this message translates to:
  /// **'By using this app you agree to our terms.\n\nThe app provides suggestions for entertainment during layovers.\n\nWe are not responsible for issues resulting from following suggestions.\n\nFor full terms, visit our website.'**
  String get terms_of_service_content;

  /// No description provided for @about_content.
  ///
  /// In en, this message translates to:
  /// **'Airport Escape helps passengers plan activities during layovers.\n\nBuilt by Team Airport Escape.\n\n© 2025 Team Airport Escape.'**
  String get about_content;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @adjust_screen_brightness.
  ///
  /// In en, this message translates to:
  /// **'Adjust screen brightness: {percent}%'**
  String adjust_screen_brightness(Object percent);

  /// No description provided for @enable_dark_theme_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable dark theme'**
  String get enable_dark_theme_subtitle;

  /// No description provided for @receive_suggestions_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive layover suggestions and updates'**
  String get receive_suggestions_subtitle;

  /// No description provided for @allow_location_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow app to access your location'**
  String get allow_location_subtitle;

  /// No description provided for @remember_searches_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Remember your recent searches'**
  String get remember_searches_subtitle;

  /// No description provided for @auto_refresh_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Automatically refresh activity suggestions'**
  String get auto_refresh_subtitle;

  /// No description provided for @view_privacy_policy_subtitle.
  ///
  /// In en, this message translates to:
  /// **'View our privacy policy'**
  String get view_privacy_policy_subtitle;

  /// No description provided for @view_terms_subtitle.
  ///
  /// In en, this message translates to:
  /// **'View terms and conditions'**
  String get view_terms_subtitle;

  /// No description provided for @reset_app_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Reset app to default settings'**
  String get reset_app_subtitle;

  /// No description provided for @reset_dialog_content.
  ///
  /// In en, this message translates to:
  /// **'This will reset all settings to their default values.\n\nThis action cannot be undone. Are you sure?'**
  String get reset_dialog_content;

  /// No description provided for @reset_confirm_button.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset_confirm_button;

  /// No description provided for @reset_success_snackbar.
  ///
  /// In en, this message translates to:
  /// **'All settings reset to defaults'**
  String get reset_success_snackbar;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In to Airport Escape'**
  String get signInTitle;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerTitle;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerButton;

  /// No description provided for @loggingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get loggingIn;

  /// No description provided for @creatingAccount.
  ///
  /// In en, this message translates to:
  /// **'Creating account...'**
  String get creatingAccount;

  /// No description provided for @authError.
  ///
  /// In en, this message translates to:
  /// **'Authentication Error'**
  String get authError;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @joinAirportEscape.
  ///
  /// In en, this message translates to:
  /// **'Join Airport Escape'**
  String get joinAirportEscape;

  /// No description provided for @check_flight_info.
  ///
  /// In en, this message translates to:
  /// **'Check Flight Info'**
  String get check_flight_info;

  /// No description provided for @set_timer.
  ///
  /// In en, this message translates to:
  /// **'Set Timer'**
  String get set_timer;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @check_flight_info_title.
  ///
  /// In en, this message translates to:
  /// **'Check Flight Info'**
  String get check_flight_info_title;

  /// No description provided for @enter_flight_code_label.
  ///
  /// In en, this message translates to:
  /// **'Enter Flight Code (e.g. AA100)'**
  String get enter_flight_code_label;

  /// No description provided for @check_status.
  ///
  /// In en, this message translates to:
  /// **'Check Status'**
  String get check_status;

  /// No description provided for @enter_flight_code_snackbar.
  ///
  /// In en, this message translates to:
  /// **'Enter a flight code (e.g. AA100)'**
  String get enter_flight_code_snackbar;

  /// No description provided for @missing_api_key_snackbar.
  ///
  /// In en, this message translates to:
  /// **'Missing API key!'**
  String get missing_api_key_snackbar;

  /// No description provided for @no_flight_found_snackbar.
  ///
  /// In en, this message translates to:
  /// **'No flight found.'**
  String get no_flight_found_snackbar;

  /// No description provided for @error_snackbar.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error_snackbar;

  /// No description provided for @running.
  ///
  /// In en, this message translates to:
  /// **'Running...'**
  String get running;

  /// No description provided for @start_timer.
  ///
  /// In en, this message translates to:
  /// **'Start Timer'**
  String get start_timer;

  /// No description provided for @timer_finished.
  ///
  /// In en, this message translates to:
  /// **'Timer finished'**
  String get timer_finished;

  /// No description provided for @countdown_complete.
  ///
  /// In en, this message translates to:
  /// **'Countdown is Complete'**
  String get countdown_complete;

  /// No description provided for @only_in_airport.
  ///
  /// In en, this message translates to:
  /// **'Only in Airport'**
  String get only_in_airport;

  /// No description provided for @no_nearby_activities.
  ///
  /// In en, this message translates to:
  /// **'No nearby activities found.'**
  String get no_nearby_activities;

  /// No description provided for @showing_places_within.
  ///
  /// In en, this message translates to:
  /// **'Showing places within {area} for a {hours}-hour layover.'**
  String showing_places_within(Object area, Object hours);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'ko',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

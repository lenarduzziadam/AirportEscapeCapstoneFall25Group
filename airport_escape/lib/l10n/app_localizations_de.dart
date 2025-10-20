// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get settings => 'Einstellungen';

  @override
  String get dark_mode => 'Dunkler Modus';

  @override
  String get language => 'Sprache';

  @override
  String get notifications => 'Push-Benachrichtigungen';

  @override
  String get location_services => 'Standortdienste';

  @override
  String get brightness => 'Helligkeit';

  @override
  String get reset_all_settings => 'Alle Einstellungen zurücksetzen';

  @override
  String get welcome_message => 'Willkommen bei Airport Escape!';

  @override
  String get restaurant => 'Restaurant';

  @override
  String get entertainment => 'Unterhaltung';

  @override
  String get shopping => 'Einkaufen';

  @override
  String get profile => 'Profil';

  @override
  String get logout => 'Abmelden';

  @override
  String get security => 'Sicherheit';

  @override
  String get general_settings => 'Allgemeine Einstellungen';

  @override
  String get airport_escape => 'Airport Escape';

  @override
  String plan_your_layover(Object category) {
    return 'Planen Sie Ihren Zwischenstopp: $category';
  }

  @override
  String get layover_duration_label => 'Zwischenstopp-Dauer (Stunden)';

  @override
  String get select_airport => 'Flughafen auswählen';

  @override
  String get please_enter_duration =>
      'Bitte geben Sie Ihre Zwischenstopp-Dauer ein.';

  @override
  String get could_not_launch_maps =>
      'Google Maps konnte nicht gestartet werden';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return 'Vorgeschlagene Aktivität in der Nähe von $airport: $activity';
  }

  @override
  String get get_directions => 'Wegbeschreibung';
}

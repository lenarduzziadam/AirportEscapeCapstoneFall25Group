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

  @override
  String get save_search_history => 'Suchverlauf speichern';

  @override
  String get auto_refresh => 'Automatische Aktualisierung';

  @override
  String get privacy_policy => 'Datenschutzerklärung';

  @override
  String get terms_of_service => 'Nutzungsbedingungen';

  @override
  String get section_privacy_and_data => 'Datenschutz & Daten';

  @override
  String get section_notifications => 'Benachrichtigungen';

  @override
  String get section_app_behavior => 'App-Verhalten';

  @override
  String get section_about => 'Über';

  @override
  String get section_reset => 'Zurücksetzen';

  @override
  String get section_general => 'Allgemein';

  @override
  String get version => 'Version';

  @override
  String get version_info =>
      'Version: 0.4.7\nBuild: 2025.10.20\nEntwickelt von Team Airport Escape\n© 2025 Alle Rechte vorbehalten';

  @override
  String get privacy_policy_content =>
      'Wir erfassen Standortdaten, um personalisierte Zwischenstopp‑Vorschläge bereitzustellen.\n\nDaten werden lokal gespeichert und nicht ohne Zustimmung weitergegeben.\n\nFür die vollständige Richtlinie besuchen Sie unsere Website.';

  @override
  String get terms_of_service_content =>
      'Durch die Nutzung dieser App stimmen Sie unseren Bedingungen zu.\n\nDie App bietet Vorschläge zur Unterhaltung während Zwischenstopps.\n\nWir übernehmen keine Verantwortung für Probleme, die sich aus der Befolgung der Vorschläge ergeben.\n\nFür die vollständigen Bedingungen besuchen Sie unsere Website.';

  @override
  String get about_content =>
      'Airport Escape hilft Passagieren, Aktivitäten während Zwischenstopps zu planen.\n\nEntwickelt von Team Airport Escape.\n\n© 2025 Team Airport Escape.';

  @override
  String get ok => 'OK';

  @override
  String get close => 'Schließen';

  @override
  String get cancel => 'Abbrechen';
}

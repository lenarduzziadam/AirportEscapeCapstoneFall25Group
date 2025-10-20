// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get settings => 'Paramètres';

  @override
  String get dark_mode => 'Mode sombre';

  @override
  String get language => 'Langue';

  @override
  String get notifications => 'Notifications push';

  @override
  String get location_services => 'Services de localisation';

  @override
  String get brightness => 'Luminosité';

  @override
  String get reset_all_settings => 'Réinitialiser tous les paramètres';

  @override
  String get welcome_message => 'Bienvenue sur Airport Escape !';

  @override
  String get restaurant => 'Restaurant';

  @override
  String get entertainment => 'Divertissement';

  @override
  String get shopping => 'Shopping';

  @override
  String get profile => 'Profil';

  @override
  String get logout => 'Déconnexion';

  @override
  String get security => 'Sécurité';

  @override
  String get general_settings => 'Paramètres généraux';

  @override
  String get airport_escape => 'Airport Escape';

  @override
  String plan_your_layover(Object category) {
    return 'Planifiez votre escale : $category';
  }

  @override
  String get layover_duration_label => 'Durée de l\'escale (heures)';

  @override
  String get select_airport => 'Sélectionnez l\'aéroport';

  @override
  String get please_enter_duration =>
      'Veuillez entrer la durée de votre escale.';

  @override
  String get could_not_launch_maps => 'Impossible d’ouvrir Google Maps';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return 'Activité suggérée près de $airport : $activity';
  }
}

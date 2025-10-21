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

  @override
  String get get_directions => 'Obtenir l\'itinéraire';

  @override
  String get save_search_history => 'Enregistrer l\'historique des recherches';

  @override
  String get auto_refresh => 'Actualisation automatique';

  @override
  String get privacy_policy => 'Politique de confidentialité';

  @override
  String get terms_of_service => 'Conditions d\'utilisation';

  @override
  String get section_privacy_and_data => 'Confidentialité et données';

  @override
  String get section_notifications => 'Notifications';

  @override
  String get section_app_behavior => 'Comportement de l\'application';

  @override
  String get section_about => 'À propos';

  @override
  String get section_reset => 'Réinitialiser';

  @override
  String get section_general => 'Général';

  @override
  String get version => 'Version';

  @override
  String get version_info =>
      'Version : 0.4.7\nBuild : 2025.10.20\nDéveloppé par Team Airport Escape\n© 2025 Tous droits réservés';

  @override
  String get privacy_policy_content =>
      'Nous collectons des données de localisation pour fournir des suggestions d\'escale personnalisées.\n\nLes données sont stockées localement et ne sont pas partagées sans consentement.\n\nPour la politique complète, visitez notre site web.';

  @override
  String get terms_of_service_content =>
      'En utilisant cette application, vous acceptez nos conditions.\n\nL\'application propose des suggestions de divertissement pendant les escales.\n\nNous ne sommes pas responsables des problèmes résultant du suivi des suggestions.\n\nPour les conditions complètes, visitez notre site web.';

  @override
  String get about_content =>
      'Airport Escape aide les passagers à planifier des activités pendant les escales.\n\nConçu par Team Airport Escape.\n\n© 2025 Team Airport Escape.';

  @override
  String get ok => 'OK';

  @override
  String get close => 'Fermer';

  @override
  String get cancel => 'Annuler';
}

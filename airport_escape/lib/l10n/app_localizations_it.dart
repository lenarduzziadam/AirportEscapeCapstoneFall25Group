// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get settings => 'Impostazioni';

  @override
  String get dark_mode => 'Modalità scura';

  @override
  String get language => 'Lingua';

  @override
  String get notifications => 'Notifiche push';

  @override
  String get location_services => 'Servizi di localizzazione';

  @override
  String get brightness => 'Luminosità';

  @override
  String get reset_all_settings => 'Ripristina tutte le impostazioni';

  @override
  String get welcome_message => 'Benvenuto in Airport Escape!';

  @override
  String get restaurant => 'Ristorante';

  @override
  String get entertainment => 'Intrattenimento';

  @override
  String get shopping => 'Shopping';

  @override
  String get profile => 'Profilo';

  @override
  String get logout => 'Disconnetti';

  @override
  String get security => 'Sicurezza';

  @override
  String get general_settings => 'Impostazioni generali';

  @override
  String get airport_escape => 'Airport Escape';

  @override
  String plan_your_layover(Object category) {
    return 'Pianifica il tuo scalo: $category';
  }

  @override
  String get layover_duration_label => 'Durata dello scalo (ore)';

  @override
  String get select_airport => 'Seleziona aeroporto';

  @override
  String get please_enter_duration => 'Inserisci la durata dello scalo.';

  @override
  String get could_not_launch_maps => 'Impossibile aprire Google Maps';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return 'Attività suggerita vicino a $airport: $activity';
  }

  @override
  String get get_directions => 'Indicazioni';

  @override
  String get save_search_history => 'Salva cronologia ricerche';

  @override
  String get auto_refresh => 'Aggiornamento automatico';

  @override
  String get privacy_policy => 'Informativa sulla privacy';

  @override
  String get terms_of_service => 'Termini di servizio';

  @override
  String get section_privacy_and_data => 'Privacy e dati';

  @override
  String get section_notifications => 'Notifiche';

  @override
  String get section_app_behavior => 'Comportamento dell\'app';

  @override
  String get section_about => 'Informazioni';

  @override
  String get section_reset => 'Ripristina';

  @override
  String get section_general => 'Generale';
}

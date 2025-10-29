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

  @override
  String get version => 'Versione';

  @override
  String get version_info =>
      'Versione: 0.4.7\nBuild: 2025.10.20\nSviluppato da Team Airport Escape\n© 2025 Tutti i diritti riservati';

  @override
  String get privacy_policy_content =>
      'Raccogliamo dati di posizione per fornire suggerimenti per le soste personalizzati.\n\nI dati sono archiviati localmente e non vengono condivisi senza consenso.\n\nPer la policy completa, visita il nostro sito web.';

  @override
  String get terms_of_service_content =>
      'Utilizzando questa app accetti i nostri termini.\n\nL\'app fornisce suggerimenti per l\'intrattenimento durante le soste.\n\nNon siamo responsabili per problemi derivanti dall\'applicazione dei suggerimenti.\n\nPer i termini completi, visita il nostro sito web.';

  @override
  String get about_content =>
      'Airport Escape aiuta i passeggeri a pianificare attività durante le soste.\n\nSviluppato da Team Airport Escape.\n\n© 2025 Team Airport Escape.';

  @override
  String get ok => 'OK';

  @override
  String get close => 'Chiudi';

  @override
  String get cancel => 'Annulla';

  @override
  String adjust_screen_brightness(Object percent) {
    return 'Regola la luminosità dello schermo: $percent%';
  }

  @override
  String get enable_dark_theme_subtitle => 'Attiva modalità scura';

  @override
  String get receive_suggestions_subtitle =>
      'Ricevi suggerimenti e aggiornamenti per la sosta';

  @override
  String get allow_location_subtitle =>
      'Consenti all\'app di accedere alla tua posizione';

  @override
  String get remember_searches_subtitle => 'Ricorda le tue ricerche recenti';

  @override
  String get auto_refresh_subtitle =>
      'Aggiorna automaticamente i suggerimenti delle attività';

  @override
  String get view_privacy_policy_subtitle =>
      'Visualizza la nostra privacy policy';

  @override
  String get view_terms_subtitle => 'Visualizza termini e condizioni';

  @override
  String get reset_app_subtitle =>
      'Reimposta l\'app alle impostazioni predefinite';

  @override
  String get reset_dialog_content =>
      'Questo reimposterà tutte le impostazioni ai valori predefiniti.\n\nQuesta azione non può essere annullata. Sei sicuro?';

  @override
  String get reset_confirm_button => 'Reimposta';

  @override
  String get reset_success_snackbar =>
      'Tutte le impostazioni sono state reimpostate ai valori predefiniti';

  @override
  String get login => 'Accedi';

  @override
  String get username => 'Nome utente';

  @override
  String get password => 'Password';

  @override
  String get login_to_your_account => 'Accedi al tuo account';

  @override
  String get favorites => 'Preferiti';
}

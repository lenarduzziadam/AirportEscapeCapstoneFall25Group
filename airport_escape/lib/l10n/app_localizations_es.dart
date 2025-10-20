// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get settings => 'Configuración';

  @override
  String get dark_mode => 'Modo oscuro';

  @override
  String get language => 'Idioma';

  @override
  String get notifications => 'Notificaciones push';

  @override
  String get location_services => 'Servicios de ubicación';

  @override
  String get brightness => 'Brillo';

  @override
  String get reset_all_settings => 'Restablecer todos los ajustes';

  @override
  String get welcome_message => '¡Bienvenido a Airport Escape!';

  @override
  String get restaurant => 'Restaurante';

  @override
  String get entertainment => 'Entretenimiento';

  @override
  String get shopping => 'Compras';

  @override
  String get profile => 'Perfil';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get security => 'Seguridad';

  @override
  String get general_settings => 'Configuración general';

  @override
  String get airport_escape => 'Airport Escape';

  @override
  String plan_your_layover(Object category) {
    return 'Planifica tu escala: $category';
  }

  @override
  String get layover_duration_label => 'Duración de la escala (horas)';

  @override
  String get select_airport => 'Selecciona aeropuerto';

  @override
  String get please_enter_duration =>
      'Por favor, ingresa la duración de tu escala.';

  @override
  String get could_not_launch_maps => 'No se pudo abrir Google Maps';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return 'Actividad sugerida cerca de $airport: $activity';
  }

  @override
  String get get_directions => 'Obtener direcciones';
}

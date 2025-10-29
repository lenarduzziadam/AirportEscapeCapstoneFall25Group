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

  @override
  String get save_search_history => 'Guardar historial de búsqueda';

  @override
  String get auto_refresh => 'Actualización automática';

  @override
  String get privacy_policy => 'Política de privacidad';

  @override
  String get terms_of_service => 'Términos de servicio';

  @override
  String get section_privacy_and_data => 'Privacidad y datos';

  @override
  String get section_notifications => 'Notificaciones';

  @override
  String get section_app_behavior => 'Comportamiento de la aplicación';

  @override
  String get section_about => 'Acerca de';

  @override
  String get section_reset => 'Restablecer';

  @override
  String get section_general => 'General';

  @override
  String get version => 'Versión';

  @override
  String get version_info =>
      'Versión: 0.4.7\nBuild: 2025.10.20\nDesarrollado por Team Airport Escape\n© 2025 Todos los derechos reservados';

  @override
  String get privacy_policy_content =>
      'Recopilamos datos de ubicación para ofrecer sugerencias de escala personalizadas.\n\nLos datos se almacenan localmente y no se comparten sin consentimiento.\n\nPara ver la política completa, visite nuestro sitio web.';

  @override
  String get terms_of_service_content =>
      'Al usar esta aplicación acepta nuestros términos.\n\nLa aplicación proporciona sugerencias de entretenimiento durante las escalas.\n\nNo somos responsables de problemas resultantes de seguir las sugerencias.\n\nPara ver los términos completos, visite nuestro sitio web.';

  @override
  String get about_content =>
      'Airport Escape ayuda a los pasajeros a planificar actividades durante las escalas.\n\nDesarrollado por Team Airport Escape.\n\n© 2025 Team Airport Escape.';

  @override
  String get ok => 'Aceptar';

  @override
  String get close => 'Cerrar';

  @override
  String get cancel => 'Cancelar';

  @override
  String adjust_screen_brightness(Object percent) {
    return 'Ajustar el brillo de la pantalla: $percent%';
  }

  @override
  String get enable_dark_theme_subtitle => 'Activar tema oscuro';

  @override
  String get receive_suggestions_subtitle =>
      'Recibir sugerencias y actualizaciones de la escala';

  @override
  String get allow_location_subtitle =>
      'Permitir que la aplicación acceda a tu ubicación';

  @override
  String get remember_searches_subtitle => 'Recordar tus búsquedas recientes';

  @override
  String get auto_refresh_subtitle =>
      'Actualizar automáticamente las sugerencias de actividades';

  @override
  String get view_privacy_policy_subtitle =>
      'Ver nuestra política de privacidad';

  @override
  String get view_terms_subtitle => 'Ver términos y condiciones';

  @override
  String get reset_app_subtitle =>
      'Restablecer la aplicación a la configuración predeterminada';

  @override
  String get reset_dialog_content =>
      'Esto restablecerá todas las configuraciones a sus valores predeterminados.\n\nEsta acción no se puede deshacer. ¿Estás seguro?';

  @override
  String get reset_confirm_button => 'Restablecer';

  @override
  String get reset_success_snackbar =>
      'Todas las configuraciones restablecidas a los valores predeterminados';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get password => 'Contraseña';

  @override
  String get login_to_your_account => 'Inicia sesión en tu cuenta';

  @override
  String get favorites => 'Favoritos';
}

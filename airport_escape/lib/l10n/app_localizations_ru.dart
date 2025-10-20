// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get settings => 'Настройки';

  @override
  String get dark_mode => 'Тёмная тема';

  @override
  String get language => 'Язык';

  @override
  String get notifications => 'Push-уведомления';

  @override
  String get location_services => 'Службы определения местоположения';

  @override
  String get brightness => 'Яркость';

  @override
  String get reset_all_settings => 'Сброс всех настроек';

  @override
  String get welcome_message => 'Добро пожаловать в Airport Escape!';

  @override
  String get restaurant => 'Ресторан';

  @override
  String get entertainment => 'Развлечения';

  @override
  String get shopping => 'Шоппинг';

  @override
  String get profile => 'Профиль';

  @override
  String get logout => 'Выйти';

  @override
  String get security => 'Безопасность';

  @override
  String get general_settings => 'Общие настройки';

  @override
  String get airport_escape => 'Airport Escape';

  @override
  String plan_your_layover(Object category) {
    return 'Планируйте свою пересадку: $category';
  }

  @override
  String get layover_duration_label => 'Длительность пересадки (часы)';

  @override
  String get select_airport => 'Выберите аэропорт';

  @override
  String get please_enter_duration =>
      'Пожалуйста, введите длительность пересадки.';

  @override
  String get could_not_launch_maps => 'Не удалось открыть Google Maps';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return 'Рекомендуемое занятие рядом с $airport: $activity';
  }

  @override
  String get get_directions => 'Построить маршрут';
}

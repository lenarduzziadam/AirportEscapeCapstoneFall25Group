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

  @override
  String get save_search_history => 'Сохранить историю поиска';

  @override
  String get auto_refresh => 'Автообновление';

  @override
  String get privacy_policy => 'Политика конфиденциальности';

  @override
  String get terms_of_service => 'Условия использования';

  @override
  String get section_privacy_and_data => 'Конфиденциальность и данные';

  @override
  String get section_notifications => 'Уведомления';

  @override
  String get section_app_behavior => 'Поведение приложения';

  @override
  String get section_about => 'О приложении';

  @override
  String get section_reset => 'Сброс';

  @override
  String get section_general => 'Общие';

  @override
  String get version => 'Версия';

  @override
  String get version_info =>
      'Версия: 0.4.7\nСборка: 2025.10.20\nРазработано: Team Airport Escape\n© 2025 Все права защищены';

  @override
  String get privacy_policy_content =>
      'Мы собираем данные о местоположении, чтобы предоставлять персонализированные рекомендации для пересадок.\n\nДанные хранятся локально и не передаются без согласия.\n\nПолную политику можно найти на нашем сайте.';

  @override
  String get terms_of_service_content =>
      'Используя это приложение, вы соглашаетесь с нашими условиями.\n\nПриложение предоставляет рекомендации по развлечениям во время пересадок.\n\nМы не несем ответственности за проблемы, возникшие в результате следования рекомендациям.\n\nПолные условия доступны на нашем сайте.';

  @override
  String get about_content =>
      'Airport Escape помогает пассажирам планировать занятия во время пересадок.\n\nРазработано Team Airport Escape.\n\n© 2025 Team Airport Escape.';

  @override
  String get ok => 'ОК';

  @override
  String get close => 'Закрыть';

  @override
  String get cancel => 'Отмена';
}

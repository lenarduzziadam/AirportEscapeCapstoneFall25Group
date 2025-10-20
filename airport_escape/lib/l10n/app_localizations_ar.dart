// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get settings => 'الإعدادات';

  @override
  String get dark_mode => 'الوضع الداكن';

  @override
  String get language => 'اللغة';

  @override
  String get notifications => 'إشعارات الدفع';

  @override
  String get location_services => 'خدمات الموقع';

  @override
  String get brightness => 'سطوع';

  @override
  String get reset_all_settings => 'إعادة تعيين جميع الإعدادات';

  @override
  String get welcome_message => 'مرحبًا بك في Airport Escape!';

  @override
  String get restaurant => 'مطعم';

  @override
  String get entertainment => 'ترفيه';

  @override
  String get shopping => 'تسوق';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get security => 'الأمان';

  @override
  String get general_settings => 'الإعدادات العامة';

  @override
  String get airport_escape => 'Airport Escape';

  @override
  String plan_your_layover(Object category) {
    return 'Plan Your Layover: $category';
  }

  @override
  String get layover_duration_label => 'Layover Duration (hours)';

  @override
  String get select_airport => 'Select Airport';

  @override
  String get please_enter_duration => 'Please enter your layover duration.';

  @override
  String get could_not_launch_maps => 'Could not launch Google Maps';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return 'Suggested activity near $airport: $activity';
  }
}

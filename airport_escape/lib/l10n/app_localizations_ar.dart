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
    return 'خطط لفترة التوقف: $category';
  }

  @override
  String get layover_duration_label => 'مدة التوقف (ساعات)';

  @override
  String get select_airport => 'اختر المطار';

  @override
  String get please_enter_duration => 'يرجى إدخال مدة التوقف الخاصة بك.';

  @override
  String get could_not_launch_maps => 'تعذر فتح خرائط Google';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return 'نشاط مقترح بالقرب من $airport: $activity';
  }

  @override
  String get get_directions => 'الحصول على الاتجاهات';

  @override
  String get save_search_history => 'حفظ سجل البحث';

  @override
  String get auto_refresh => 'التحديث التلقائي';

  @override
  String get privacy_policy => 'سياسة الخصوصية';

  @override
  String get terms_of_service => 'شروط الخدمة';

  @override
  String get section_privacy_and_data => 'الخصوصية والبيانات';

  @override
  String get section_notifications => 'الإشعارات';

  @override
  String get section_app_behavior => 'سلوك التطبيق';

  @override
  String get section_about => 'حول';

  @override
  String get section_reset => 'إعادة تعيين';

  @override
  String get section_general => 'عام';

  @override
  String get version => 'الإصدار';

  @override
  String get version_info =>
      'الإصدار: 0.4.7\nالبناء: 2025.10.20\nتطوير: Team Airport Escape\n© 2025 جميع الحقوق محفوظة';

  @override
  String get privacy_policy_content =>
      'نقوم بجمع بيانات الموقع لتقديم اقتراحات مخصصة لفترات التوقف.\n\nيتم تخزين البيانات محليًا ولا تتم مشاركتها دون موافقة.\n\nللاطلاع على السياسة الكاملة، قم بزيارة موقعنا الإلكتروني.';

  @override
  String get terms_of_service_content =>
      'باستخدام هذا التطبيق، فإنك توافق على شروطنا.\n\nيقدّم التطبيق اقتراحات للترفيه أثناء فترات التوقف.\n\nلسنا مسؤولين عن المشاكل الناتجة عن اتباع الاقتراحات.\n\nللاطّلاع على الشروط الكاملة، قم بزيارة موقعنا الإلكتروني.';

  @override
  String get about_content =>
      'يساعد Airport Escape الركاب على تخطيط الأنشطة أثناء فترات التوقف.\n\nطوّره Team Airport Escape.\n\n© 2025 Team Airport Escape.';

  @override
  String get ok => 'حسناً';

  @override
  String get close => 'إغلاق';

  @override
  String get cancel => 'إلغاء';

  @override
  String adjust_screen_brightness(Object percent) {
    return 'ضبط سطوع الشاشة: $percent%';
  }

  @override
  String get enable_dark_theme_subtitle => 'تمكين الوضع الداكن';

  @override
  String get receive_suggestions_subtitle => 'استلام اقتراحات وتحديثات التوقف';

  @override
  String get allow_location_subtitle => 'السماح للتطبيق بالوصول إلى موقعك';

  @override
  String get remember_searches_subtitle => 'تذكّر عمليات البحث الأخيرة';

  @override
  String get auto_refresh_subtitle => 'تحديث الاقتراحات تلقائيًا';

  @override
  String get view_privacy_policy_subtitle => 'عرض سياسة الخصوصية الخاصة بنا';

  @override
  String get view_terms_subtitle => 'عرض الشروط والأحكام';

  @override
  String get reset_app_subtitle => 'إعادة التطبيق إلى إعدادات المصنع';

  @override
  String get reset_dialog_content =>
      'سيؤدي ذلك إلى إعادة جميع الإعدادات إلى قيمها الافتراضية.\n\nلا يمكن التراجع عن هذا الإجراء. هل أنت متأكد؟';

  @override
  String get reset_confirm_button => 'إعادة تعيين';

  @override
  String get reset_success_snackbar =>
      'تمت إعادة جميع الإعدادات إلى القيم الافتراضية';

  @override
  String get login => 'Login';

  @override
  String get username => 'Username';

  @override
  String get login_to_your_account => 'Login to your account';

  @override
  String get favorites => 'المفضلة';
}

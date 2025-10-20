// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get dark_mode => 'डार्क मोड';

  @override
  String get language => 'भाषा';

  @override
  String get notifications => 'पुश सूचनाएं';

  @override
  String get location_services => 'स्थान सेवाएं';

  @override
  String get brightness => 'चमक';

  @override
  String get reset_all_settings => 'सभी सेटिंग्स रीसेट करें';

  @override
  String get welcome_message => 'Airport Escape में आपका स्वागत है!';

  @override
  String get restaurant => 'रेस्टोरेंट';

  @override
  String get entertainment => 'मनोरंजन';

  @override
  String get shopping => 'खरीदारी';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get security => 'सुरक्षा';

  @override
  String get general_settings => 'सामान्य सेटिंग्स';

  @override
  String get airport_escape => 'Airport Escape';

  @override
  String plan_your_layover(Object category) {
    return 'अपनी लेओवर योजना बनाएं: $category';
  }

  @override
  String get layover_duration_label => 'लेओवर अवधि (घंटे)';

  @override
  String get select_airport => 'हवाई अड्डा चुनें';

  @override
  String get please_enter_duration => 'कृपया अपनी लेओवर अवधि दर्ज करें।';

  @override
  String get could_not_launch_maps => 'Google Maps लॉन्च नहीं किया जा सका';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return '$airport के पास सुझाई गई गतिविधि: $activity';
  }

  @override
  String get get_directions => 'दिशा प्राप्त करें';
}

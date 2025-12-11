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
  String get plan_your_layover => 'अपनी लेओवर योजना बनाएं';

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

  @override
  String get save_search_history => 'खोज इतिहास सहेजें';

  @override
  String get auto_refresh => 'स्वचालित ताज़ा';

  @override
  String get privacy_policy => 'गोपनीयता नीति';

  @override
  String get terms_of_service => 'सेवा की शर्तें';

  @override
  String get section_privacy_and_data => 'गोपनीयता और डेटा';

  @override
  String get section_notifications => 'सूचनाएं';

  @override
  String get section_app_behavior => 'ऐप व्यवहार';

  @override
  String get section_about => 'जानकारी';

  @override
  String get section_reset => 'रीसेट';

  @override
  String get section_general => 'सामान्य';

  @override
  String get version => 'संस्करण';

  @override
  String get version_info =>
      'संस्करण: 0.4.7\nबिल्ड: 2025.10.20\nविकसित: Team Airport Escape\n© 2025 सर्वाधिकार सुरक्षित';

  @override
  String get privacy_policy_content =>
      'हम स्थान डेटा एकत्र करते हैं ताकि व्यक्तिगत लेओवर सुझाव प्रदान किए जा सकें।\n\nडेटा स्थानीय रूप से संग्रहीत किया जाता है और सहमति के बिना साझा नहीं किया जाता।\n\nपूर्ण नीति के लिए हमारी वेबसाइट देखें।';

  @override
  String get terms_of_service_content =>
      'इस ऐप का उपयोग करके आप हमारी शर्तों से सहमत होते हैं।\n\nयह ऐप लेओवर के दौरान मनोरंजन के सुझाव प्रदान करता है।\n\nसुझावों का पालन करने से उत्पन्न किसी भी समस्या के लिए हम जिम्मेदार नहीं हैं।\n\nपूर्ण शर्तें हमारी वेबसाइट पर देखें।';

  @override
  String get about_content =>
      'Airport Escape यात्रियों को लेओवर के दौरान गतिविधियाँ योजनाबद्ध करने में मदद करता है।\n\nTeam Airport Escape द्वारा विकसित।\n\n© 2025 Team Airport Escape.';

  @override
  String get ok => 'ठीक है';

  @override
  String get close => 'बंद करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String adjust_screen_brightness(Object percent) {
    return 'स्क्रीन चमक समायोजित करें: $percent%';
  }

  @override
  String get enable_dark_theme_subtitle => 'डार्क मोड सक्षम करें';

  @override
  String get receive_suggestions_subtitle =>
      'लेओवर सुझाव और अपडेट प्राप्त करें';

  @override
  String get allow_location_subtitle =>
      'ऐप को आपके स्थान तक पहुंच की अनुमति दें';

  @override
  String get remember_searches_subtitle => 'आपकी हाल की खोज को याद रखें';

  @override
  String get auto_refresh_subtitle =>
      'गतिविधि सुझाव स्वचालित रूप से ताज़ा करें';

  @override
  String get view_privacy_policy_subtitle => 'हमारी गोपनीयता नीति देखें';

  @override
  String get view_terms_subtitle => 'नियम और शर्तें देखें';

  @override
  String get reset_app_subtitle => 'ऐप को डिफ़ॉल्ट सेटिंग्स पर रीसेट करें';

  @override
  String get reset_dialog_content =>
      'यह सभी सेटिंग्स को उनके डिफ़ॉल्ट मानों पर रीसेट कर देगा।\n\nइस क्रिया को पूर्ववत नहीं किया जा सकता। क्या आप सुनिश्चित हैं?';

  @override
  String get reset_confirm_button => 'रीसेट';

  @override
  String get reset_success_snackbar =>
      'सभी सेटिंग्स डिफ़ॉल्ट मानों पर रीसेट कर दी गईं';

  @override
  String get signIn => 'साइन इन करें';

  @override
  String get register => 'रजिस्टर करें';

  @override
  String get email => 'ईमेल';

  @override
  String get password => 'पासवर्ड';

  @override
  String get emailAddress => 'ईमेल पता';

  @override
  String get enterPassword => 'पासवर्ड दर्ज करें';

  @override
  String get signInTitle => 'Airport Escape में साइन इन करें';

  @override
  String get registerTitle => 'खाता बनाएं';

  @override
  String get alreadyHaveAccount => 'क्या आपके पास पहले से खाता है?';

  @override
  String get dontHaveAccount => 'क्या आपके पास खाता नहीं है?';

  @override
  String get signInButton => 'साइन इन करें';

  @override
  String get registerButton => 'खाता बनाएं';

  @override
  String get loggingIn => 'साइन इन हो रहा है...';

  @override
  String get creatingAccount => 'खाता बनाया जा रहा है...';

  @override
  String get authError => 'प्रमाणीकरण त्रुटि';

  @override
  String get welcomeBack => 'वापसी पर स्वागत है';

  @override
  String get joinAirportEscape => 'Airport Escape में शामिल हों';

  @override
  String get check_flight_info => 'फ्लाइट जानकारी जांचें';

  @override
  String get set_timer => 'टाइमर सेट करें';

  @override
  String get category => 'श्रेणी';

  @override
  String get check_flight_info_title => 'फ्लाइट जानकारी जांचें';

  @override
  String get enter_flight_code_label => 'फ्लाइट कोड दर्ज करें (जैसे AA100)';

  @override
  String get check_status => 'स्थिति जांचें';

  @override
  String get enter_flight_code_snackbar =>
      'कृपया फ्लाइट कोड दर्ज करें (जैसे AA100)';

  @override
  String get missing_api_key_snackbar => 'API कुंजी गायब है!';

  @override
  String get no_flight_found_snackbar => 'कोई फ्लाइट नहीं मिली।';

  @override
  String get error_snackbar => 'त्रुटि';
}

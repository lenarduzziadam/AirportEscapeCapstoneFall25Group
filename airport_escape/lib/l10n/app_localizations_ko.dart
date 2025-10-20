// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get settings => '설정';

  @override
  String get dark_mode => '다크 모드';

  @override
  String get language => '언어';

  @override
  String get notifications => '푸시 알림';

  @override
  String get location_services => '위치 서비스';

  @override
  String get brightness => '밝기';

  @override
  String get reset_all_settings => '모든 설정 초기화';

  @override
  String get welcome_message => 'Airport Escape에 오신 것을 환영합니다!';

  @override
  String get restaurant => '레스토랑';

  @override
  String get entertainment => '엔터테인먼트';

  @override
  String get shopping => '쇼핑';

  @override
  String get profile => '프로필';

  @override
  String get logout => '로그아웃';

  @override
  String get security => '보안';

  @override
  String get general_settings => '일반 설정';

  @override
  String get airport_escape => 'Airport Escape';

  @override
  String plan_your_layover(Object category) {
    return '환승 계획하기: $category';
  }

  @override
  String get layover_duration_label => '환승 시간 (시간)';

  @override
  String get select_airport => '공항 선택';

  @override
  String get please_enter_duration => '환승 시간을 입력하세요.';

  @override
  String get could_not_launch_maps => 'Google 지도 실행에 실패했습니다';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return '$airport 근처 추천 활동: $activity';
  }

  @override
  String get get_directions => '길찾기';

  @override
  String get save_search_history => '검색 기록 저장';

  @override
  String get auto_refresh => '자동 새로고침';

  @override
  String get privacy_policy => '개인정보 처리방침';

  @override
  String get terms_of_service => '서비스 약관';

  @override
  String get section_privacy_and_data => '개인정보 및 데이터';

  @override
  String get section_notifications => '알림';

  @override
  String get section_app_behavior => '앱 동작';

  @override
  String get section_about => '정보';

  @override
  String get section_reset => '초기화';

  @override
  String get section_general => '일반';
}

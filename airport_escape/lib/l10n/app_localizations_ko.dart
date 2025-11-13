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
  String get plan_your_layover => '환승 계획하기';

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

  @override
  String get version => '버전';

  @override
  String get version_info =>
      '버전: 0.4.7\n빌드: 2025.10.20\n개발: Team Airport Escape\n© 2025 판권 소유';

  @override
  String get privacy_policy_content =>
      '환승 제안을 개인화하기 위해 위치 데이터를 수집합니다.\n\n데이터는 로컬에 저장되며 동의 없이 공유되지 않습니다.\n\n전체 정책은 웹사이트를 참조하세요.';

  @override
  String get terms_of_service_content =>
      '이 앱을 사용하면 이용약관에 동의하는 것으로 간주됩니다.\n\n앱은 환승 중 즐길거리에 대한 제안을 제공합니다.\n\n제안을 따른 결과 발생한 문제에 대해 책임지지 않습니다.\n\n전체 약관은 웹사이트에서 확인하세요.';

  @override
  String get about_content =>
      'Airport Escape는 환승 중 활동을 계획하는 데 도움을 줍니다.\n\nTeam Airport Escape 개발.\n\n© 2025 Team Airport Escape.';

  @override
  String get ok => '확인';

  @override
  String get close => '닫기';

  @override
  String get cancel => '취소';

  @override
  String adjust_screen_brightness(Object percent) {
    return '화면 밝기 조정: $percent%';
  }

  @override
  String get enable_dark_theme_subtitle => '다크 모드 활성화';

  @override
  String get receive_suggestions_subtitle => '환승 추천 및 업데이트 받기';

  @override
  String get allow_location_subtitle => '앱이 위치에 접근하도록 허용';

  @override
  String get remember_searches_subtitle => '최근 검색을 저장';

  @override
  String get auto_refresh_subtitle => '활동 추천 자동 새로고침';

  @override
  String get view_privacy_policy_subtitle => '개인정보 처리방침 보기';

  @override
  String get view_terms_subtitle => '약관 보기';

  @override
  String get reset_app_subtitle => '앱을 기본 설정으로 재설정';

  @override
  String get reset_dialog_content =>
      '모든 설정이 기본값으로 재설정됩니다.\n\n이 작업은 되돌릴 수 없습니다. 계속하시겠습니까?';

  @override
  String get reset_confirm_button => '재설정';

  @override
  String get reset_success_snackbar => '모든 설정이 기본값으로 재설정되었습니다';
}

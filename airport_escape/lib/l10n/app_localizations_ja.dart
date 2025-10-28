// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get settings => '設定';

  @override
  String get dark_mode => 'ダークモード';

  @override
  String get language => '言語';

  @override
  String get notifications => 'プッシュ通知';

  @override
  String get location_services => '位置情報サービス';

  @override
  String get brightness => '明るさ';

  @override
  String get reset_all_settings => 'すべての設定をリセット';

  @override
  String get welcome_message => 'Airport Escapeへようこそ！';

  @override
  String get restaurant => 'レストラン';

  @override
  String get entertainment => 'エンターテインメント';

  @override
  String get shopping => 'ショッピング';

  @override
  String get profile => 'プロフィール';

  @override
  String get logout => 'ログアウト';

  @override
  String get security => 'セキュリティ';

  @override
  String get general_settings => '一般設定';

  @override
  String get airport_escape => 'Airport Escape';

  @override
  String plan_your_layover(Object category) {
    return '乗り継ぎを計画する: $category';
  }

  @override
  String get layover_duration_label => '乗り継ぎ時間（時間）';

  @override
  String get select_airport => '空港を選択';

  @override
  String get please_enter_duration => '乗り継ぎ時間を入力してください。';

  @override
  String get could_not_launch_maps => 'Googleマップを開けませんでした';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return '$airport付近のおすすめアクティビティ: $activity';
  }

  @override
  String get get_directions => 'ルートを表示';

  @override
  String get save_search_history => '検索履歴を保存';

  @override
  String get auto_refresh => '自動更新';

  @override
  String get privacy_policy => 'プライバシーポリシー';

  @override
  String get terms_of_service => '利用規約';

  @override
  String get section_privacy_and_data => 'プライバシーとデータ';

  @override
  String get section_notifications => '通知';

  @override
  String get section_app_behavior => 'アプリの動作';

  @override
  String get section_about => '約';

  @override
  String get section_reset => 'リセット';

  @override
  String get section_general => '一般';

  @override
  String get version => 'バージョン';

  @override
  String get version_info =>
      'バージョン: 0.4.7\nビルド: 2025.10.20\n開発: Team Airport Escape\n© 2025 全著作権所有';

  @override
  String get privacy_policy_content =>
      '乗り継ぎの提案を個別化するために位置データを収集します。\n\nデータはローカルに保存され、同意なしに共有されません。\n\n完全なポリシーについてはウェブサイトをご覧ください。';

  @override
  String get terms_of_service_content =>
      '本アプリを使用することで、当社の利用規約に同意したものとみなされます。\n\nアプリは乗り継ぎ中の娯楽に関する提案を行います。\n\n提案に従った結果生じた問題については責任を負いません。\n\n完全な条件についてはウェブサイトをご覧ください。';

  @override
  String get about_content =>
      'Airport Escapeは乗り継ぎ中の活動を計画する手助けをします。\n\nTeam Airport Escapeによる開発。\n\n© 2025 Team Airport Escape.';

  @override
  String get ok => 'OK';

  @override
  String get close => '閉じる';

  @override
  String get cancel => 'キャンセル';

  @override
  String adjust_screen_brightness(Object percent) {
    return '画面の明るさを調整: $percent%';
  }

  @override
  String get enable_dark_theme_subtitle => 'ダークモードを有効にする';

  @override
  String get receive_suggestions_subtitle => '乗り継ぎの提案と更新を受け取る';

  @override
  String get allow_location_subtitle => 'アプリが位置情報にアクセスすることを許可';

  @override
  String get remember_searches_subtitle => '最近の検索を保存する';

  @override
  String get auto_refresh_subtitle => 'アクティビティの提案を自動更新';

  @override
  String get view_privacy_policy_subtitle => 'プライバシーポリシーを見る';

  @override
  String get view_terms_subtitle => '利用規約を見る';

  @override
  String get reset_app_subtitle => 'アプリをデフォルト設定にリセット';

  @override
  String get reset_dialog_content =>
      'これにより、すべての設定がデフォルト値にリセットされます。\n\nこの操作は元に戻せません。本当に実行しますか？';

  @override
  String get reset_confirm_button => 'リセット';

  @override
  String get reset_success_snackbar => 'すべての設定がデフォルトにリセットされました';

  @override
  String get login => 'Login';

  @override
  String get username => 'Username';

  @override
  String get login_to_your_account => 'Login to your account';
}

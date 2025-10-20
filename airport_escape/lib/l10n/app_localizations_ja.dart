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
}

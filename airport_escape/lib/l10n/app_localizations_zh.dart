// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get settings => '设置';

  @override
  String get dark_mode => '深色模式';

  @override
  String get language => '语言';

  @override
  String get notifications => '推送通知';

  @override
  String get location_services => '位置服务';

  @override
  String get brightness => '亮度';

  @override
  String get reset_all_settings => '重置所有设置';

  @override
  String get welcome_message => '欢迎使用 Airport Escape！';

  @override
  String get restaurant => '餐厅';

  @override
  String get entertainment => '娱乐';

  @override
  String get shopping => '购物';

  @override
  String get profile => '个人资料';

  @override
  String get logout => '退出登录';

  @override
  String get security => '安全';

  @override
  String get general_settings => '常规设置';

  @override
  String get airport_escape => 'Airport Escape';

  @override
  String plan_your_layover(Object category) {
    return '规划您的中转：$category';
  }

  @override
  String get layover_duration_label => '中转时长（小时）';

  @override
  String get select_airport => '选择机场';

  @override
  String get please_enter_duration => '请输入您的中转时长。';

  @override
  String get could_not_launch_maps => '无法打开谷歌地图';

  @override
  String suggested_activity_near(Object activity, Object airport) {
    return '$airport附近推荐活动：$activity';
  }

  @override
  String get get_directions => '获取路线';
}

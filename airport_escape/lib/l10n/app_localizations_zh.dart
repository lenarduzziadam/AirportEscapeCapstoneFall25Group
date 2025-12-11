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
  String get plan_your_layover => '规划您的中转';

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

  @override
  String get save_search_history => '保存搜索历史';

  @override
  String get auto_refresh => '自动刷新';

  @override
  String get privacy_policy => '隐私政策';

  @override
  String get terms_of_service => '服务条款';

  @override
  String get section_privacy_and_data => '隐私与数据';

  @override
  String get section_notifications => '通知';

  @override
  String get section_app_behavior => '应用行为';

  @override
  String get section_about => '关于';

  @override
  String get section_reset => '重置';

  @override
  String get section_general => '常规';

  @override
  String get version => '版本';

  @override
  String get version_info =>
      '版本：0.4.7\n构建：2025.10.20\n开发：Team Airport Escape\n© 2025 版权所有';

  @override
  String get privacy_policy_content =>
      '我们收集位置信息以提供个性化的中转建议。\n\n数据会本地存储，未经同意不会共享。\n\n完整政策请访问我们的网站。';

  @override
  String get terms_of_service_content =>
      '使用本应用即表示您同意我们的服务条款。\n\n该应用提供中转期间的娱乐建议。\n\n对于因遵循建议而产生的问题，我们不承担责任。\n\n完整条款请访问我们的网站。';

  @override
  String get about_content =>
      'Airport Escape 帮助乘客规划中转期间的活动。\n\n由 Team Airport Escape 开发。\n\n© 2025 Team Airport Escape.';

  @override
  String get ok => '确定';

  @override
  String get close => '关闭';

  @override
  String get cancel => '取消';

  @override
  String adjust_screen_brightness(Object percent) {
    return '调整屏幕亮度：$percent%';
  }

  @override
  String get enable_dark_theme_subtitle => '启用深色模式';

  @override
  String get receive_suggestions_subtitle => '接收中转建议和更新';

  @override
  String get allow_location_subtitle => '允许应用访问您的位置';

  @override
  String get remember_searches_subtitle => '记住您的最近搜索';

  @override
  String get auto_refresh_subtitle => '自动刷新活动建议';

  @override
  String get view_privacy_policy_subtitle => '查看我们的隐私政策';

  @override
  String get view_terms_subtitle => '查看服务条款';

  @override
  String get reset_app_subtitle => '将应用重置为默认设置';

  @override
  String get reset_dialog_content => '这将把所有设置重置为默认值。\n\n此操作无法撤销。确定要继续吗？';

  @override
  String get reset_confirm_button => '重置';

  @override
  String get reset_success_snackbar => '所有设置已重置为默认值';

  @override
  String get signIn => '登录';

  @override
  String get register => '注册';

  @override
  String get email => '电子邮件';

  @override
  String get password => '密码';

  @override
  String get emailAddress => '电子邮件地址';

  @override
  String get enterPassword => '输入密码';

  @override
  String get signInTitle => '登录 Airport Escape';

  @override
  String get registerTitle => '创建账户';

  @override
  String get alreadyHaveAccount => '已有账户？';

  @override
  String get dontHaveAccount => '还没有账户？';

  @override
  String get signInButton => '登录';

  @override
  String get registerButton => '创建账户';

  @override
  String get loggingIn => '登录中...';

  @override
  String get creatingAccount => '创建账户中...';

  @override
  String get authError => '认证错误';

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get joinAirportEscape => '加入 Airport Escape';

  @override
  String get check_flight_info => '查看航班信息';

  @override
  String get set_timer => '设置计时器';

  @override
  String get category => '类别';

  @override
  String get check_flight_info_title => '查看航班信息';

  @override
  String get enter_flight_code_label => '输入航班号（如AA100）';

  @override
  String get check_status => '查询状态';

  @override
  String get enter_flight_code_snackbar => '请输入航班号（如AA100）';

  @override
  String get missing_api_key_snackbar => '缺少API密钥！';

  @override
  String get no_flight_found_snackbar => '未找到航班。';

  @override
  String get error_snackbar => '错误';
}

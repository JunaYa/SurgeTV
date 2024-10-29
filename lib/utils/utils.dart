import 'package:surgetv/utils/log_util.dart';
import 'package:surgetv/utils/notice_util.dart';
import 'package:surgetv/utils/package_util.dart';
import 'package:surgetv/utils/pref.dart';
import 'package:surgetv/utils/theme_util.dart';

class Utils {
  Utils._();

  static final Utils _instance = Utils._();

  factory Utils() => _instance;

  late final PrefUtil prefUtil = PrefUtil();

  late final PackageUtil packageUtil = PackageUtil();

  late final ThemeUtil themeUtil = ThemeUtil();

  late final LogUtil logUtil = LogUtil();

  late final NoticeUtil noticeUtil = NoticeUtil();
}

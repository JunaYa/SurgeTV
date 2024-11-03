import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surgetv/config/constants.dart';
import 'package:surgetv/utils/utils.dart';

class PrefUtil {
  late final SharedPreferencesWithCache _prefs;

  static const allowList = {
    //应用版本
    'appVersion',
    //首次启动标识
    'firstStart',
    //自动同步
    'autoSync',
    //动态配色支持
    'supportDynamicColor',
    //颜色选择方法
    'colorSelectionMethod',
    //主题颜色
    'themeColor',
    //主题图片
    'themeImage',
    //主题模式
    'themeMode',
    //Material版本
    'useMaterial3',
    //语言
    'language',
    //动态配色
    'dynamicColor',
    //图片质量
    'quality',
    //本地化
    'local',
    //应用锁
    'lock',
    //uuid
    'uuid',
    //字体缩放
    'fontScale',
    //立即锁定
    'lockNow',
    //字体样式
    'fontTheme',
    //和风key
    'qweatherKey',
    'tencentId',
    'tencentKey',
    //侧边栏天气
    'getWeather',
    //天气缓存
    'weather',
    //一言缓存
    'hitokoto',
    //图片缓存
    'bingImage',
    //第一次打开的时间
    'startTime',
    //应用文档路径
    'supportPath',
    //缓存路径
    'cachePath',
    //密码
    'password',
    //生物识别支持
    'supportBiometrics',
    //自定义首页名称
    'customTitleName',
  };

  Future<void> initPref() async {
    _prefs = await SharedPreferencesWithCache.create(
        cacheOptions:
            const SharedPreferencesWithCacheOptions(allowList: allowList));
    // 首次启动
    var firstStart = _prefs.getBool('firstStart') ?? true;
    await _prefs.setBool('firstStart', firstStart);

    // 获取当前应用版本
    var packageInfo = await Utils().packageUtil.getPackageInfo();
    var currentVersion = '${packageInfo.version}+${packageInfo.buildNumber}';
    var appVersion = _prefs.getString('appVersion');

    // 如果是首次启动或版本不一致
    if (kDebugMode ||
        firstStart ||
        appVersion == null ||
        appVersion != currentVersion) {
      await _prefs.setString('appVersion', currentVersion);
      await setDefaultValues();
    }
  }

  // 设置默认值的方法
  Future<void> setDefaultValues() async {
    await _prefs.setBool('autoSync', _prefs.getBool('autoSync') ?? false);
    await _prefs.setBool(
        'supportDynamicColor',
        _prefs.getBool('supportDynamicColor') ??
            await Utils().themeUtil.supportDynamicColor());
    await _prefs.setInt(
        'themeColor',
        _prefs.getInt('themeColor') ??
            (await Utils().themeUtil.supportDynamicColor() ? -1 : 0));
    await _prefs.setInt('themeImage', _prefs.getInt('themeImage') ?? 0);
    await _prefs.setInt(
        'colorSelectionMethod', _prefs.getInt('colorSelectionMethod') ?? 0);
    await _prefs.setInt('themeMode', _prefs.getInt('themeMode') ?? 0);
    await _prefs.setBool(
        'useMaterial3', _prefs.getBool('useMaterial3') ?? true);
    await _prefs.setBool(
        'dynamicColor', _prefs.getBool('dynamicColor') ?? true);
    await _prefs.setString('language', _prefs.getString('language') ?? 'zh');
    await _prefs.setInt('quality', _prefs.getInt('quality') ?? 2);
    await _prefs.setBool('local', _prefs.getBool('local') ?? false);
    await _prefs.setBool('lock', _prefs.getBool('lock') ?? false);
    await _prefs.setDouble('fontScale', _prefs.getDouble('fontScale') ?? 1.0);
    await _prefs.setBool('lockNow', _prefs.getBool('lockNow') ?? false);
    await _prefs.setInt('fontTheme', _prefs.getInt('fontTheme') ?? 0);
    await _prefs.setInt('startTime',
        _prefs.getInt('startTime') ?? DateTime.now().millisecondsSinceEpoch);
    await _prefs.setString(
        'customTitleName', _prefs.getString('customTitleName') ?? '');
  }

  Future<void> setValue<T>(String key, T value) async {
    if (T == int) {
      await _prefs.setInt(key, value as int);
    } else if (T == bool) {
      await _prefs.setBool(key, value as bool);
    } else if (T == double) {
      await _prefs.setDouble(key, value as double);
    } else if (T == String) {
      await _prefs.setString(key, value as String);
    } else if (T == List<String>) {
      await _prefs.setStringList(key, value as List<String>);
    } else if (T == ThemeMode) {
      await _prefs.setInt(key, (value as ThemeMode).index);
    } else if (T == ColorSeed) {
      await _prefs.setInt(key, (value as ColorSeed).index);
    } else if (T == ColorImageProvider) {
      await _prefs.setInt(key, (value as ColorImageProvider).index);
    } else if (T == ColorSelectionMethod) {
      await _prefs.setInt(key, (value as ColorSelectionMethod).index);
    } else {
      throw ArgumentError('Unsupported type: $T');
    }
  }

  T? getValue<T>(String key) {
    if (T == int) {
      return _prefs.getInt(key) as T?;
    } else if (T == bool) {
      return _prefs.getBool(key) as T?;
    } else if (T == double) {
      return _prefs.getDouble(key) as T?;
    } else if (T == String) {
      return _prefs.getString(key) as T?;
    } else if (T == List<String>) {
      return _prefs.getStringList(key) as T?;
    } else if (T == ThemeMode) {
      return ThemeMode.values[_prefs.getInt(key) ?? 0] as T?;
    } else if (T == ColorSeed) {
      return ColorSeed.values[_prefs.getInt(key) ?? 0] as T?;
    } else if (T == ColorImageProvider) {
      return ColorImageProvider.values[_prefs.getInt(key) ?? 0] as T?;
    } else if (T == ColorSelectionMethod) {
      return ColorSelectionMethod.values[_prefs.getInt(key) ?? 0] as T?;
    } else {
      throw ArgumentError('Unsupported type: $T');
    }
  }

  Future<void> removeValue(String key) async {
    await _prefs.remove(key);
  }
}

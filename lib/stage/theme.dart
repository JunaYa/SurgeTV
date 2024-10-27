// theme_manager.dart
import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Color _primaryColor = Colors.blue;
  
  ThemeMode get themeMode => _themeMode;
  Color get primaryColor => _primaryColor;
  
  // 切换明暗主题
  void toggleThemeMode() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  
  // 更新主题色
  void updatePrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }
  
  // 获取当前主题
  ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: _primaryColor,
      primaryColor: _primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      brightness: Brightness.light,
    );
  }
  
  ThemeData get darkTheme {
    return ThemeData(
      primaryColor: _primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}

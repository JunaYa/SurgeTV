// theme_manager.dart
import 'package:flutter/material.dart';
import 'package:surgetv/config/constants.dart';

class ThemeManager extends ChangeNotifier {
  bool useMaterial3 = true;
  bool get useLightMode => switch (themeMode) {
        ThemeMode.system => true,
        // View.of(context).platformDispatcher.platformBrightness ==
        //     Brightness.light,
        ThemeMode.light => true,
        ThemeMode.dark => false,
      };
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.baseColor;
  ColorImageProvider imageSelected = ColorImageProvider.leaves;
  ColorScheme? imageColorScheme = const ColorScheme.light();
  ColorSelectionMethod colorSelectionMethod = ColorSelectionMethod.colorSeed;

  Color get primaryColor => colorSelected.color;

  // 切换明暗主题
  void toggleThemeMode() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void handleMaterialVersionChange() {
    useMaterial3 = !useMaterial3;
    notifyListeners();
  }

  void handleImageSelect(int value) {
    final String url = ColorImageProvider.values[value].url;
    ColorScheme.fromImageProvider(provider: NetworkImage(url))
        .then((newScheme) {
      colorSelectionMethod = ColorSelectionMethod.image;
      imageSelected = ColorImageProvider.values[value];
      imageColorScheme = newScheme;
    });
    notifyListeners();
  }

  void handleColorSelect(int value) {
    colorSelectionMethod = ColorSelectionMethod.colorSeed;
    colorSelected = ColorSeed.values[value];
    notifyListeners();
  }

  // 获取当前主题
  ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed
          ? colorSelected.color
          : null,
      colorScheme: colorSelectionMethod == ColorSelectionMethod.image
          ? imageColorScheme
          : null,
      useMaterial3: useMaterial3,
      brightness: Brightness.light,
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed
          ? colorSelected.color
          : imageColorScheme!.primary,
      brightness: Brightness.dark,
      useMaterial3: true,
    );
  }
}

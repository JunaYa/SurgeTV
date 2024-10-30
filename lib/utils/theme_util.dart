import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:surgetv/config/constants.dart';
import 'package:surgetv/utils/utils.dart';

class ThemeUtil {
  Future<bool> supportDynamicColor() async {
    return (await DynamicColorPlugin.getCorePalette()) != null;
  }

  Future<Color> getDynamicColor() async {
    return Color((await DynamicColorPlugin.getCorePalette())!.primary.get(40));
  }

  Future<ThemeData> buildTheme(Brightness brightness) async {
    ColorSelectionMethod colorSelectionMethod = Utils()
        .prefUtil
        .getValue<ColorSelectionMethod>('colorSelectionMethod')!;
    ColorSeed? colorSelected =
        Utils().prefUtil.getValue<ColorSeed>('themeColor');
    ColorImageProvider? themeImage =
        Utils().prefUtil.getValue<ColorImageProvider>('themeImage');
    bool? useMaterial3 = Utils().prefUtil.getValue<bool>('useMaterial3');

    String url = ColorImageProvider.values[themeImage!.index].url;
    ColorScheme? imageColorScheme;

    if (colorSelectionMethod == ColorSelectionMethod.image) {
      imageColorScheme =
          await ColorScheme.fromImageProvider(provider: NetworkImage(url));
    }

    if (brightness == Brightness.light) {
      return ThemeData(
        colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed
            ? colorSelected?.color
            : null,
        colorScheme: colorSelectionMethod == ColorSelectionMethod.image
            ? imageColorScheme
            : null,
        useMaterial3: useMaterial3,
        brightness: Brightness.light,
      );
    } else {
      return ThemeData(
        colorSchemeSeed: colorSelectionMethod == ColorSelectionMethod.colorSeed
            ? colorSelected?.color
            : imageColorScheme?.primary,
        useMaterial3: useMaterial3,
        brightness: Brightness.dark,
      );
    }
  }
}

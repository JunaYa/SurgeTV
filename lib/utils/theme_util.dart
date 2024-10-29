import 'dart:io';

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
    final color = Utils().prefUtil.getValue<int>('color');
    var seedColor = switch (color) {
      0 => ColorSeed.baseColor.color,
      1 => ColorSeed.indigo.color,
      2 => ColorSeed.blue.color,
      3 => ColorSeed.teal.color,
      4 => ColorSeed.green.color,
      5 => ColorSeed.yellow.color,
      6 => ColorSeed.orange.color,
      7 => ColorSeed.deepOrange.color,
      8 => ColorSeed.pink.color,
      //-1为系统配色，如果选了-1，肯定有
      _ => await getDynamicColor()
    };

    var themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
        dynamicSchemeVariant: color == 4
            ? DynamicSchemeVariant.fidelity
            : DynamicSchemeVariant.tonalSpot,
      ),
      fontFamily: Platform.isWindows ? '微软雅黑' : null,
    );

    return themeData;
  }
}

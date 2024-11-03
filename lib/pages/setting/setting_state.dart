import 'package:flutter/material.dart';
import 'package:surgetv/config/constants.dart';
import 'package:surgetv/utils/utils.dart';

class SettingState {
  late bool useMaterial3;
  late ThemeMode themeMode;
  late ColorSeed colorSelected;
  late ColorImageProvider imageSelected;
  late ColorSelectionMethod colorSelectionMethod =
      ColorSelectionMethod.colorSeed;
  late String language;

  SettingState() {
    // 初始化状态
    themeMode = Utils().prefUtil.getValue<ThemeMode>('themeMode')!;
    colorSelectionMethod = (Utils()
        .prefUtil
        .getValue<ColorSelectionMethod>('colorSelectionMethod'))!;
    colorSelected = Utils().prefUtil.getValue<ColorSeed>('themeColor')!;

    imageSelected =
        Utils().prefUtil.getValue<ColorImageProvider>('themeImage')!;
    useMaterial3 = Utils().prefUtil.getValue<bool>('useMaterial3')!;
    language = Utils().prefUtil.getValue<String>('language')!;
  }
}

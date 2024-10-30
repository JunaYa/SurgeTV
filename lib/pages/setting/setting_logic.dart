import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgetv/config/constants.dart';
import 'package:surgetv/utils/utils.dart';
import 'setting_state.dart';

class SettingLogic extends GetxController {
  final SettingState state = SettingState();

  // toggle theme mode
  void toggleThemeMode() {
    state.themeMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    Utils().prefUtil.setValue('themeMode', state.themeMode);
    Get.changeThemeMode(state.themeMode);
    Get.forceAppUpdate();
  }

  // toggle material version
  Future<void> toggleMaterialVersion() async {
    await Utils().prefUtil.setValue('useMaterial3', state.useMaterial3);
    state.useMaterial3 = !state.useMaterial3;
    Get.changeTheme(await Utils().themeUtil.buildTheme(Brightness.light));
    Get.changeTheme(await Utils().themeUtil.buildTheme(Brightness.dark));
  }

  // color select
  Future<void> handleColorSelect(int value) async {
    await Utils().prefUtil.setValue('themeColor', value);
    await Utils()
        .prefUtil
        .setValue('colorSelectionMethod', ColorSelectionMethod.colorSeed);
    state.colorSelectionMethod = ColorSelectionMethod.colorSeed;
    state.colorSelected = ColorSeed.values[value];
    Get.changeTheme(await Utils().themeUtil.buildTheme(Brightness.light));
    Get.changeTheme(await Utils().themeUtil.buildTheme(Brightness.dark));
  }

  // image select
  Future<void> handleImageSelect(int value) async {
    await Utils().prefUtil.setValue('themeImage', value);
    await Utils()
        .prefUtil
        .setValue('colorSelectionMethod', ColorSelectionMethod.image);
    state.colorSelectionMethod = ColorSelectionMethod.image;
    state.imageSelected = ColorImageProvider.values[value];
    Get.changeTheme(await Utils().themeUtil.buildTheme(Brightness.light));
    Get.changeTheme(await Utils().themeUtil.buildTheme(Brightness.dark));
  }
}

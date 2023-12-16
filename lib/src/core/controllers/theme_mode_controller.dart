import 'package:face_detection_app/src/core/constants/storage_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeModeController extends GetxController {
  static ThemeModeController get of => Get.find();

  GetStorage storage = GetStorage();
  ThemeMode _themeMode = ThemeMode.system;

  Future<void> set(ThemeMode value) async {
    Get.changeThemeMode(value);
    _themeMode = value;
    update();
    await storage.write(
      StorageKey.theme.name,
      value.name,
    );
  }

  Future<void> toggle() async {
    final value =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(value);
    _themeMode = value;
    update();
    await storage.write(
      StorageKey.theme.name,
      value.name,
    );
  }

  getThemeModeFromPreferences() async {
    ThemeMode themeMode;
    String? themeText = storage.read(StorageKey.theme.name);
    if (themeText == null) {
      final brightness = PlatformDispatcher.instance.platformBrightness;
      themeText = brightness == Brightness.light
          ? ThemeMode.light.name
          : ThemeMode.dark.name;
    }
    try {
      themeMode = ThemeMode.values.firstWhere((e) => e.name == themeText);
    } catch (e) {
      themeMode = ThemeMode.system;
    }
    set(themeMode);
  }
}

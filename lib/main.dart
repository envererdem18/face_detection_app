import 'package:face_detection_app/src/core/controllers/theme_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/features/face_detection_app.dart';

void main() async {
  await GetStorage.init();
  Get.lazyPut<ThemeModeController>(() => ThemeModeController());
  ThemeModeController.of.getThemeModeFromPreferences();
  runApp(const FaceDetectionApp());
}

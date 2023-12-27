import 'package:face_detection_app/src/controllers/theme_mode_controller.dart';
import 'package:get/get.dart';

class MainBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<ThemeModeController>(() => ThemeModeController());
    ThemeModeController.of.getThemeModeFromPreferences();
  }
}

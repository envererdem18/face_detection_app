import 'package:face_detection_app/src/screens/home/home_screen.dart';
import 'package:face_detection_app/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class FaceDetectionApp extends StatelessWidget {
  const FaceDetectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const HomeScreen(),
    );
  }
}

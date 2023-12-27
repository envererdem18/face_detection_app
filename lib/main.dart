import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'di.dart';
import 'src/screens/face_detection_app.dart';

void main() async {
  await GetStorage.init();

  MainBinding mainBinding = MainBinding();
  await mainBinding.dependencies();
  runApp(const FaceDetectionApp());
}

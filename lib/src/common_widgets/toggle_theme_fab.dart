import 'package:face_detection_app/src/core/controllers/theme_mode_controller.dart';
import 'package:flutter/material.dart';

class ToggleThemeFAB extends StatelessWidget {
  const ToggleThemeFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? Icons.light_mode
            : Icons.dark_mode,
      ),
      onPressed: () => ThemeModeController.of.toggle(),
    );
  }
}

import 'package:face_detection_app/src/screens/home/home_mixin.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/toggle_theme_fab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with HomeMixin {
  @override
  void dispose() {
    faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () async =>
                      await showBottomSheetForSource(context),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 100),
                    backgroundColor:
                        Theme.of(context).colorScheme.onInverseSurface,
                  ),
                  child: const Icon(Icons.add, size: 45),
                ),
                const SizedBox(height: 16),
                Card(
                  color: Theme.of(context).colorScheme.background,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Tap to Add Photo'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const ToggleThemeFAB(),
    );
  }
}

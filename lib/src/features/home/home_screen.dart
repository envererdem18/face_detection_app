import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../common_widgets/toggle_theme_fab.dart';
import '../image/image_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

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
                  onPressed: () async => await _showBottomSheet(),
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

  Future<void> _showBottomSheet() async {
    await Get.bottomSheet(CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            Get.back();
            await _getImage();
          },
          isDefaultAction: true,
          child: const Text('From Gallery'),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            Get.back();
            await _getCamera();
          },
          child: const Text('From Camera'),
        ),
      ],
    ));
  }

  Future _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _showSnackBar(image);
  }

  Future _getCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    _showSnackBar(image);
  }

  _showSnackBar(XFile? image) {
    if (image == null && mounted) {
      Get.showSnackbar(
        GetSnackBar(
          messageText: Text(
            'No image selected.',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(milliseconds: 1000),
          snackStyle: SnackStyle.GROUNDED,
        ),
      );
      return;
    }
    Get.to(ImageScreen(image: image));
  }
}

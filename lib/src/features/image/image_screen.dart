import 'dart:io';

import 'package:badges/badges.dart' as b;
import 'package:face_detection_app/src/features/gallery/image_gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

part './widgets/selected_face_widget.dart';
part './widgets/selected_faces_list_widget.dart';

class ImageScreen extends StatelessWidget {
  final XFile? image;
  const ImageScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            label: const Text('Accept'),
            icon: const Icon(Icons.check),
            onPressed: () => Get.to(
              const ImageGalleryScreen(),
              fullscreenDialog: true,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: image == null
                    ? const Text('No image selected.')
                    : Image.file(File(image!.path)),
              ),
            ),
            const _SelectedFacesListWidget(),
          ],
        ),
      ),
    );
  }
}

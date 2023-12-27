import 'package:face_detection_app/src/utils/global_loading_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

import '../image_preview/image_preview_screen.dart';
import '../image_preview/models/image_screen_viewmodel.dart';

mixin HomeMixin {
  final ImagePicker _picker = ImagePicker();

  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    ),
  );

  Future<void> showBottomSheetForSource(BuildContext context) async {
    await Get.bottomSheet(CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            Get.back();
            await _getImage(ImageSource.gallery, context);
          },
          isDefaultAction: true,
          child: const Text('From Gallery'),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            Get.back();
            await _getImage(ImageSource.camera, context);
          },
          child: const Text('From Camera'),
        ),
      ],
    ));
  }

  Future _getImage(ImageSource source, BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (context.mounted) {
      _processImage(image, context);
    }
  }

  Future<void> _processImage(XFile? image, BuildContext context) async {
    if (image == null) {
      _showErrorSnackbar(context);
      return;
    }
    late ImageScreenViewModel imageScreenViewModel;
    await context.globalLoadingWrapper(
      () async {
        final path = image.path;
        final inputImage = InputImage.fromFilePath(path);
        final faces = await faceDetector.processImage(inputImage);
        imageScreenViewModel = ImageScreenViewModel(
          faces: faces,
          inputImage: inputImage,
        );
      },
    );
    Get.to(ImagePreviewScreen(viewModel: imageScreenViewModel));
  }

  _showErrorSnackbar(BuildContext context) => Get.showSnackbar(
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
}

import 'dart:async';
import 'dart:io';

import 'package:badges/badges.dart' as b;
import 'package:camera/camera.dart';
import 'package:face_detection_app/src/painters/face_detector_painter.dart';
import 'package:face_detection_app/src/screens/gallery/image_gallery_screen.dart';
import 'package:face_detection_app/src/screens/image_preview/models/image_screen_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as image;

part './widgets/selected_face_widget.dart';
part './widgets/selected_faces_list_widget.dart';

class ImagePreviewScreen extends StatefulWidget {
  final ImageScreenViewModel viewModel;
  const ImagePreviewScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  Size? size;
  final List<Image> _croppedImages = [];

  _calculateImageDimension() async {
    Completer<Size> completer = Completer();
    final image = Image.file(File(widget.viewModel.inputImage.filePath!));
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    size = await completer.future;
    setState(() {});
  }

  _cropImages() {
    if (widget.viewModel.faces == null) return;
    for (var face in widget.viewModel.faces!) {
      final imageBytes = image.decodeImage(
        File(widget.viewModel.inputImage.filePath!).readAsBytesSync(),
      )!;
      Rect rect = face.boundingBox;
      final result = Uint8List.fromList(
        image.encodePng(
          image.copyCrop(
            imageBytes,
            x: rect.left.toInt(),
            y: rect.top.toInt(),
            width: rect.width.toInt(),
            height: rect.height.toInt(),
          ),
        ),
      );
      _croppedImages.add(Image.memory(result));
    }
  }

  @override
  void initState() {
    super.initState();
    _calculateImageDimension();
    _cropImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: widget.viewModel.faces?.isNotEmpty ?? false,
            child: TextButton.icon(
              label: const Text('Go To Gallery'),
              icon: const Icon(Icons.chevron_right),
              onPressed: () => Get.to(
                ImageGalleryScreen(images: _croppedImages),
                fullscreenDialog: true,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Stack(
                  children: [
                    Opacity(
                      opacity: .8,
                      child: Image.file(
                        File(widget.viewModel.inputImage.filePath!),
                      ),
                    ),
                    CustomPaint(
                      foregroundPainter: size != null
                          ? FaceDetectorPainter(
                              widget.viewModel.faces!,
                              Size(size!.width, size!.height),
                              InputImageRotation.rotation0deg,
                              CameraLensDirection.back,
                            )
                          : null,
                      child: Opacity(
                        opacity: 0,
                        child: Image.file(
                          File(widget.viewModel.inputImage.filePath!),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                '${widget.viewModel.faces?.length ?? "Zero"} faces detected',
                style: TextStyle(
                  color: widget.viewModel.faces == null ||
                          widget.viewModel.faces!.isEmpty
                      ? Colors.red
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            _SelectedFacesListWidget(croppedImages: _croppedImages),
          ],
        ),
      ),
    );
  }
}

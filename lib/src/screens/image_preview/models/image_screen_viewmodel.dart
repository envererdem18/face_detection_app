import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class ImageScreenViewModel {
  final List<Face>? faces;
  final InputImage inputImage;
  ImageScreenViewModel({
    this.faces,
    required this.inputImage,
  });
}

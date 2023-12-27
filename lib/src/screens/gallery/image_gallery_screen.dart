import 'package:flutter/material.dart';

class ImageGalleryScreen extends StatelessWidget {
  final List<Image> images;
  const ImageGalleryScreen({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: images
                .map(
                  (image) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Image(
                          fit: BoxFit.cover,
                          image: image.image,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

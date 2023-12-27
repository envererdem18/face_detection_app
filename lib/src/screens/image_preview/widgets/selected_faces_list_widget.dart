part of '../image_preview_screen.dart';

class _SelectedFacesListWidget extends StatelessWidget {
  final List<Image> croppedImages;
  const _SelectedFacesListWidget({
    Key? key,
    required this.croppedImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 116,
          child: ListView.separated(
            itemCount: croppedImages.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            separatorBuilder: (ctx, index) => const SizedBox(width: 16),
            itemBuilder: (ctx, index) => _SelectedFaceWidget(
              croppedImage: croppedImages[index],
            ),
          ),
        ),
      ],
    );
  }
}

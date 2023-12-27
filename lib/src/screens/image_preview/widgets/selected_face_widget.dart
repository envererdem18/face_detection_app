part of '../image_preview_screen.dart';

class _SelectedFaceWidget extends StatefulWidget {
  final Image croppedImage;
  const _SelectedFaceWidget({
    Key? key,
    required this.croppedImage,
  }) : super(key: key);

  @override
  State<_SelectedFaceWidget> createState() => _SelectedFaceWidgetState();
}

class _SelectedFaceWidgetState extends State<_SelectedFaceWidget> {
  @override
  Widget build(BuildContext context) {
    return b.Badge(
      position: b.BadgePosition.topEnd(),
      badgeContent: const Icon(
        Icons.close,
        size: 14,
      ),
      badgeStyle: b.BadgeStyle(
        badgeColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 80,
          width: 80,
          child: Center(child: widget.croppedImage),
        ),
      ),
    );
  }
}

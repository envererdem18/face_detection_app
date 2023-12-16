part of '../image_screen.dart';

class _SelectedFaceWidget extends StatelessWidget {
  final int index;
  const _SelectedFaceWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

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
      child: SizedBox(
        height: 80,
        width: 80,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: const Border(),
            borderRadius: BorderRadius.circular(16),
            color: Colors.red,
          ),
          child: Center(
            child: Text('Face $index'),
          ),
        ),
      ),
    );
  }
}

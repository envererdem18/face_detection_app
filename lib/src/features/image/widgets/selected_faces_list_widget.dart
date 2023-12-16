part of '../image_screen.dart';

class _SelectedFacesListWidget extends StatelessWidget {
  const _SelectedFacesListWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 116,
          child: ListView.separated(
            itemCount: 8,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            separatorBuilder: (ctx, index) => const SizedBox(width: 16),
            itemBuilder: (ctx, index) => _SelectedFaceWidget(index: index),
          ),
        ),
      ],
    );
  }
}

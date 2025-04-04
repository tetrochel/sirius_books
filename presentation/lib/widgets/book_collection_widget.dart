import 'package:flutter/material.dart';
import 'package:presentation/theme/theme_picker.dart';
import 'package:presentation/utils/placeholder_painter.dart';

class BookCollectionWidget extends StatelessWidget {
  final String name;
  final void Function() onTap;
  final String bookCount;

  const BookCollectionWidget({
    super.key,
    required this.name,
    required this.onTap,
    required this.bookCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: PlaceholderPainter(
                    seed: name,
                    isVertical: false,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      name,
                      style: context.textStyles.s24w400.copyWith(
                        color: context.colors.primary,
                        height: 1,
                      ),
                    ),
                  ),
                  Text(
                    bookCount,
                    style: context.textStyles.s14w400.copyWith(color: context.colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

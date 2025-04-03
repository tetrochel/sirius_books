import 'package:flutter/material.dart';
import 'package:presentation/theme/theme_picker.dart';
import 'package:presentation/utils/placeholder_painter.dart';

class BookWidget extends StatelessWidget {
  final String name;
  final String authorName;
  final String genre;
  final void Function() onTap;
  final void Function() onTapBookmark;

  const BookWidget({
    super.key,
    required this.name,
    required this.authorName,
    required this.genre,
    required this.onTap,
    required this.onTapBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.white,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 60,
                    child: CustomPaint(
                      painter: PlaceholderPainter(
                        seed: 'book:$name,authorName$authorName,genre:$genre',
                        isVertical: true,
                      ),
                      child: SizedBox.expand(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: context.textStyles.s14w600.copyWith(color: context.colors.primary),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  genre,
                                  style: context.textStyles.s12w400.copyWith(color: context.colors.grey),
                                ),
                                Text(
                                  authorName,
                                  style: context.textStyles.s14w400,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            splashRadius: 10,
                            onPressed: onTapBookmark,
                            icon: Icon(
                              Icons.collections_bookmark,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

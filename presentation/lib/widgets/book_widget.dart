import 'package:flutter/material.dart';
import 'package:presentation/theme/theme_picker.dart';

class BookWidget extends StatelessWidget {
  final String name;
  final String authorName;
  final String genre;
  final bool isFavorite;
  final void Function() onTap;
  final void Function() onTapFavorite;

  const BookWidget({
    super.key,
    required this.name,
    required this.authorName,
    required this.genre,
    required this.isFavorite,
    required this.onTap,
    required this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    // TODO(ivan): change to image
                    child: Container(color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        genre,
                        style: context.textStyles.s14w400
                            .copyWith(color: context.colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -12,
                    right: -4,
                    child: _BookmarkButton(
                      isFavorite: isFavorite,
                      onTapFavorite: onTapFavorite,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    child: Text(
                      name,
                      style: context.textStyles.s16w600
                          .copyWith(color: context.colors.primary),
                    ),
                  ),
                  Text(
                    authorName,
                    style: context.textStyles.s14w400
                        .copyWith(color: context.colors.grey),
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

class _BookmarkButton extends StatelessWidget {
  final bool isFavorite;
  final void Function() onTapFavorite;

  const _BookmarkButton({
    required this.isFavorite,
    required this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTapFavorite,
      icon: Icon(
        isFavorite ? Icons.bookmark : Icons.bookmark_border,
        size: 32,
        color: isFavorite ? context.colors.primary : context.colors.grey,
      ),
    );
  }
}

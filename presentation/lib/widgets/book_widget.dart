import 'dart:math';
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
      color: context.colors.white,
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
                    child: CustomPaint(
                      size: Size(double.infinity, double.infinity),
                      painter: _PlaceholderPainter(
                          'book:$name,authotName$authorName,genre:$genre'),
                    ),
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

class _PlaceholderPainter extends CustomPainter {
  final String seed;

  _PlaceholderPainter(this.seed);

  @override
  void paint(Canvas canvas, Size size) {
    final hash = seed.hashCode;
    final Random random = Random(hash);

    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.pink,
      Colors.purple,
      Colors.orange,
      Colors.teal
    ];
    final Color baseColor = colors[hash % colors.length].withOpacity(0.7);

    final Paint paint = Paint()..color = baseColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    switch (hash % 4) {
      case 0:
        _drawGrid(canvas, size, random);
        break;
      case 1:
        _drawCircles(canvas, size, random);
        break;
      case 2:
        _drawStripes(canvas, size, random);
        break;
      case 3:
        _drawWaves(canvas, size, random);
        break;
    }
  }

  void _drawGrid(Canvas canvas, Size size, Random random) {
    final Paint paint = Paint()..color = Colors.black.withOpacity(0.1);
    final int rows = 6;
    final int cols = 10;
    final double cellWidth = size.width / cols;
    final double cellHeight = size.height / rows;

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (random.nextBool()) {
          canvas.drawRect(
            Rect.fromLTWH(i * cellWidth, j * cellHeight, cellWidth, cellHeight),
            paint,
          );
        }
      }
    }
  }

  void _drawCircles(Canvas canvas, Size size, Random random) {
    final Paint paint = Paint()..color = Colors.white.withOpacity(0.2);
    for (int i = 0; i < 10; i++) {
      final double radius = random.nextDouble() * 30 + 10;
      final double x = random.nextDouble() * size.width;
      final double y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  void _drawStripes(Canvas canvas, Size size, Random random) {
    final Paint paint = Paint()..color = Colors.black.withOpacity(0.1);
    for (double i = 0; i < size.width; i += 20) {
      canvas.drawRect(Rect.fromLTWH(i, 0, 10, size.height), paint);
    }
  }

  void _drawWaves(Canvas canvas, Size size, Random random) {
    final Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final double waveHeight = 20;
    final double waveWidth = 40;

    for (double y = size.height * 0.3; y < size.height; y += 30) {
      Path path = Path();
      path.moveTo(0, y);
      for (double x = 0; x <= size.width; x += waveWidth) {
        path.quadraticBezierTo(
          x + waveWidth / 4,
          y - waveHeight,
          x + waveWidth / 2,
          y,
        );
        path.quadraticBezierTo(
          x + 3 * waveWidth / 4,
          y + waveHeight,
          x + waveWidth,
          y,
        );
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

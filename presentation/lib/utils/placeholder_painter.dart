import 'dart:math';

import 'package:flutter/material.dart';

class PlaceholderPainter extends CustomPainter {
  final String seed;
  final bool isVertical;

  PlaceholderPainter({
    required this.seed,
    required this.isVertical,
  });

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
      Colors.teal,
    ];
    final Color baseColor = colors[hash % colors.length].withValues(alpha: 0.7);

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
    final Paint paint = Paint()..color = Colors.black.withValues(alpha: 0.1);
    final int rows = isVertical ? 10 : 6;
    final int cols = isVertical ? 6 : 10;
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
    final Paint paint = Paint()..color = Colors.white.withValues(alpha: 0.2);
    for (int i = 0; i < 10; i++) {
      final double radius = random.nextDouble() * 30 + 10;
      final double x = random.nextDouble() * size.width;
      final double y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  void _drawStripes(Canvas canvas, Size size, Random random) {
    final Paint paint = Paint()..color = Colors.black.withValues(alpha: 0.1);
    if (isVertical) {
      for (double i = 0; i < size.height; i += 20) {
        canvas.drawRect(Rect.fromLTWH(0, i, size.width, 10), paint);
      }
    } else {
      for (double i = 0; i < size.width; i += 20) {
        canvas.drawRect(Rect.fromLTWH(i, 0, 10, size.height), paint);
      }
    }
  }

  void _drawWaves(Canvas canvas, Size size, Random random) {
    final Paint paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final double waveHeight = 10;
    final double waveWidth = 30;

    for (double y = size.height * 0.2; y < size.height; y += 30) {
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

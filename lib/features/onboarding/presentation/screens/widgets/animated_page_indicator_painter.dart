import 'package:flutter/material.dart';

/// Alternative implementation using CustomPainter for more advanced animations
class AnimatedPageIndicatorPainter extends StatelessWidget {
  final PageController controller;
  final int count;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double activeDotWidth;
  final double spacing;

  const AnimatedPageIndicatorPainter({
    super.key,
    required this.controller,
    required this.count,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.dotSize = 10.0,
    this.activeDotWidth = 24.0,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final currentPage = controller.hasClients
            ? (controller.page ?? 0)
            : 0.0;

        return CustomPaint(
          size: Size(
            (count * dotSize) + ((count - 1) * spacing) + activeDotWidth,
            dotSize,
          ),
          painter: _PageIndicatorPainter(
            currentPage: currentPage,
            count: count,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            dotSize: dotSize,
            activeDotWidth: activeDotWidth,
            spacing: spacing,
          ),
        );
      },
    );
  }
}

class _PageIndicatorPainter extends CustomPainter {
  final double currentPage;
  final int count;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double activeDotWidth;
  final double spacing;

  _PageIndicatorPainter({
    required this.currentPage,
    required this.count,
    required this.activeColor,
    required this.inactiveColor,
    required this.dotSize,
    required this.activeDotWidth,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < count; i++) {
      final xPos = i * (dotSize + spacing);
      final selectedness = (1.0 - (currentPage - i).abs()).clamp(0.0, 1.0);
      final width = dotSize + (activeDotWidth - dotSize) * selectedness;
      final color = Color.lerp(inactiveColor, activeColor, selectedness)!;

      paint.color = color;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(xPos, 0, width, dotSize),
        Radius.circular(dotSize / 2),
      );

      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(_PageIndicatorPainter oldDelegate) {
    return currentPage != oldDelegate.currentPage;
  }
}

import 'package:flutter/material.dart';

/// Custom animated page indicator with smooth transitions
class AnimatedPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;
  final Color activeColor;
  final Color inactiveColor;
  final double? dotSize;
  final double? activeDotWidth;
  final double? spacing;
  final Duration animationDuration;
  final Curve animationCurve;

  const AnimatedPageIndicator({
    super.key,
    required this.controller,
    required this.count,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.dotSize,
    this.activeDotWidth,
    this.spacing,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizes with defaults
    final responsiveDotSize = dotSize ?? (screenWidth * 0.025).clamp(8.0, 12.0);
    final responsiveActiveDotWidth = activeDotWidth ?? (screenWidth * 0.06).clamp(20.0, 28.0);
    final responsiveSpacing = spacing ?? (screenWidth * 0.02).clamp(6.0, 10.0);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Get current page position (can be fractional during swipe)
        final currentPage = controller.hasClients
            ? (controller.page ?? 0)
            : 0.0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(count, (index) {
            return _buildDot(
              index,
              currentPage,
              responsiveDotSize,
              responsiveActiveDotWidth,
              responsiveSpacing,
            );
          }),
        );
      },
    );
  }

  Widget _buildDot(
      int index,
      double currentPage,
      double dotSize,
      double activeDotWidth,
      double spacing,
      ) {
    // Calculate how close this dot is to being active (0.0 to 1.0)
    final double selectedness = (1.0 - (currentPage - index).abs())
        .clamp(0.0, 1.0);

    // Interpolate width between inactive and active sizes
    final double width = dotSize + (activeDotWidth - dotSize) * selectedness;

    // Interpolate color between inactive and active
    final Color color = Color.lerp(
      inactiveColor,
      activeColor,
      selectedness,
    )!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing / 2),
      child: AnimatedContainer(
        duration: animationDuration,
        curve: animationCurve,
        width: width,
        height: dotSize,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(dotSize / 2),
        ),
      ),
    );
  }
}
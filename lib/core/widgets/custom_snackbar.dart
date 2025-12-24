import 'package:flutter/material.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'snackbar_type.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 4),
  }) {
    // Fix the Navigator/Overlay issue by using a more robust approach
    OverlayState? overlay;

    // Try multiple approaches to get the overlay
    try {
      // First, try to get overlay directly from context
      overlay = Overlay.maybeOf(context);

      // If that fails, try to get it from the Navigator
      if (overlay == null) {
        final navigator = Navigator.of(context, rootNavigator: true);
        overlay = navigator.overlay;
      }
    } catch (e) {
      // If all approaches fail, fallback to ScaffoldMessenger
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: _getBackgroundColorForType(type),
            duration: duration,
          ),
        );
        return;
      } catch (scaffoldError) {
        // If even ScaffoldMessenger fails, do nothing
        return;
      }
    }

    // If we still don't have an overlay, fallback to ScaffoldMessenger
    if (overlay == null) {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: _getBackgroundColorForType(type),
            duration: duration,
          ),
        );
        return;
      } catch (e) {
        // If ScaffoldMessenger fails, do nothing
        return;
      }
    }

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _SnackBarWidget(
        title: title,
        message: message,
        type: type,
        onDismiss: () => overlayEntry.remove(),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      try {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
        }
      } catch (e) {
        // Ignore errors when removing overlay entry
      }
    });
  }

  static Color _getBackgroundColorForType(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return AppColors.successGreen;
      case SnackBarType.info:
        return AppColors.infoBlue;
      case SnackBarType.warning:
        return AppColors.warningYellow;
      case SnackBarType.error:
        return AppColors.errorRed;
      case SnackBarType.cart:
        return AppColors.cartPurple;
    }
  }

  static void showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context: context,
      title: title,
      message: message,
      type: SnackBarType.success,
      duration: duration,
    );
  }

  static void showInfo({
    required BuildContext context,
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context: context,
      title: title,
      message: message,
      type: SnackBarType.info,
      duration: duration,
    );
  }

  static void showWarning({
    required BuildContext context,
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context: context,
      title: title,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
    );
  }

  static void showError({
    required BuildContext context,
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context: context,
      title: title,
      message: message,
      type: SnackBarType.error,
      duration: duration,
    );
  }

  static void showCart({
    required BuildContext context,
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context: context,
      title: title,
      message: message,
      type: SnackBarType.cart,
      duration: duration,
    );
  }
}

class _SnackBarWidget extends StatefulWidget {
  final String title;
  final String message;
  final SnackBarType type;
  final VoidCallback onDismiss;

  const _SnackBarWidget({
    required this.title,
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  @override
  State<_SnackBarWidget> createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<_SnackBarWidget>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _iconController;
  late AnimationController _progressController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _iconRotation;
  late Animation<double> _iconScale;

  @override
  void initState() {
    super.initState();

    // Slide & Fade Animation
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -1.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Scale Animation for Card
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    // Icon Animation
    _iconController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _iconRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.elasticOut),
    );

    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeOutBack),
    );

    // Progress Animation
    _progressController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Start animations
    _slideController.forward();
    _scaleController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _iconController.forward();
        _progressController.forward();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    _iconController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _slideController.reverse();
    await _scaleController.reverse();
    widget.onDismiss();
  }

  Color _getBackgroundColor() {
    switch (widget.type) {
      case SnackBarType.success:
        return AppColors.successGreenBg;
      case SnackBarType.info:
        return AppColors.infoBlueBg;
      case SnackBarType.warning:
        return AppColors.warningYellowBg;
      case SnackBarType.error:
        return AppColors.errorRedBg;
      case SnackBarType.cart:
        return AppColors.cartPurpleBg;
    }
  }

  Color _getBorderColor() {
    switch (widget.type) {
      case SnackBarType.success:
        return AppColors.successGreenBorder;
      case SnackBarType.info:
        return AppColors.infoBlueBorder;
      case SnackBarType.warning:
        return AppColors.warningYellowBorder;
      case SnackBarType.error:
        return AppColors.errorRedBorder;
      case SnackBarType.cart:
        return AppColors.cartPurpleBorder;
    }
  }

  Color _getIconColor() {
    switch (widget.type) {
      case SnackBarType.success:
        return AppColors.successGreen;
      case SnackBarType.info:
        return AppColors.infoBlue;
      case SnackBarType.warning:
        return AppColors.warningYellow;
      case SnackBarType.error:
        return AppColors.errorRed;
      case SnackBarType.cart:
        return AppColors.cartPurple;
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case SnackBarType.success:
        return Icons.check_circle_rounded;
      case SnackBarType.info:
        return Icons.lightbulb_rounded;
      case SnackBarType.warning:
        return Icons.warning_rounded;
      case SnackBarType.error:
        return Icons.cancel_rounded;
      case SnackBarType.cart:
        return Icons.shopping_cart_rounded;
    }
  }

  List<Color> _getGradientColors() {
    switch (widget.type) {
      case SnackBarType.success:
        return [
          AppColors.successGreen.withOpacity(0.1),
          AppColors.successGreenBg,
        ];
      case SnackBarType.info:
        return [AppColors.infoBlue.withOpacity(0.1), AppColors.infoBlueBg];
      case SnackBarType.warning:
        return [
          AppColors.warningYellow.withOpacity(0.1),
          AppColors.warningYellowBg,
        ];
      case SnackBarType.error:
        return [AppColors.errorRed.withOpacity(0.1), AppColors.errorRedBg];
      case SnackBarType.cart:
        return [AppColors.cartPurple.withOpacity(0.1), AppColors.cartPurpleBg];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Material(
              color: Colors.transparent,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Glow Effect
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: _getIconColor().withOpacity(0.4),
                            blurRadius: 30,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Main Card with Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _getGradientColors(),
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _getBorderColor(), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          // Animated Background Pattern
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _PatternPainter(
                                color: _getIconColor().withOpacity(0.05),
                              ),
                            ),
                          ),

                          // Progress Bar
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: AnimatedBuilder(
                              animation: _progressController,
                              builder: (context, child) {
                                return LinearProgressIndicator(
                                  value: _progressController.value,
                                  backgroundColor: Colors.transparent,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    _getIconColor().withOpacity(0.3),
                                  ),
                                  minHeight: 4,
                                );
                              },
                            ),
                          ),

                          // Content
                          Padding(
                            padding: const EdgeInsets.all(18),
                            child: Row(
                              children: [
                                // Animated Icon
                                AnimatedBuilder(
                                  animation: _iconController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _iconScale.value,
                                      child: Transform.rotate(
                                        angle: _iconRotation.value * 0.5,
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                _getIconColor(),
                                                _getIconColor().withOpacity(
                                                  0.7,
                                                ),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: _getIconColor()
                                                    .withOpacity(0.5),
                                                blurRadius: 12,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            _getIcon(),
                                            color: AppColors.white,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(width: 16),

                                // Text Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        widget.title,
                                        style: AppTextStyles.poppinsBold
                                            .copyWith(
                                              fontSize: 17,
                                              color: AppColors.black,
                                              letterSpacing: 0.3,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        widget.message,
                                        style: AppTextStyles.poppinsRegular
                                            .copyWith(
                                              fontSize: 14,
                                              color: AppColors.black
                                                  .withOpacity(0.75),
                                              height: 1.4,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // Close Button with Animation
                                GestureDetector(
                                  onTap: _dismiss,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.black.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: AppColors.black.withOpacity(0.7),
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Floating Particles Effect
                  ...List.generate(3, (index) {
                    return Positioned(
                      top: -10 + (index * 5.0),
                      right: 20 + (index * 30.0),
                      child: _FloatingParticle(
                        color: _getIconColor(),
                        delay: index * 200,
                        size: 6 - (index * 1.5),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Painter for Background Pattern
class _PatternPainter extends CustomPainter {
  final Color color;

  _PatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const spacing = 30.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Floating Particle Widget
class _FloatingParticle extends StatefulWidget {
  final Color color;
  final int delay;
  final double size;

  const _FloatingParticle({
    required this.color,
    required this.delay,
    required this.size,
  });

  @override
  State<_FloatingParticle> createState() => _FloatingParticleState();
}

class _FloatingParticleState extends State<_FloatingParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value * 20 - 10),
          child: Opacity(
            opacity: 0.6,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

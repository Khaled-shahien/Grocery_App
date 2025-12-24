import 'package:flutter/material.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'dart:math' as math;

enum LoadingType {
  login,
  register,
  loading,
  processing,
  uploading,
  downloading,
}

class CustomLoadingDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    LoadingType type = LoadingType.loading,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => _LoadingDialogWidget(
        title: title,
        message: message,
        type: type,
      ),
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // Helper Methods
  static void showLogin(BuildContext context) {
    show(
      context: context,
      title: 'جاري تسجيل الدخول',
      message: 'يرجى الانتظار بينما نقوم بتسجيل دخولك...',
      type: LoadingType.login,
    );
  }

  static void showRegister(BuildContext context) {
    show(
      context: context,
      title: 'جاري إنشاء الحساب',
      message: 'نقوم بإنشاء حسابك الآن، لن يستغرق الأمر طويلاً...',
      type: LoadingType.register,
    );
  }

  static void showProcessing(BuildContext context, {String? customMessage}) {
    show(
      context: context,
      title: 'جاري المعالجة',
      message: customMessage ?? 'نقوم بمعالجة طلبك...',
      type: LoadingType.processing,
    );
  }

  static void showUploading(BuildContext context) {
    show(
      context: context,
      title: 'جاري الرفع',
      message: 'يتم رفع الملفات الآن...',
      type: LoadingType.uploading,
    );
  }

  static void showDownloading(BuildContext context) {
    show(
      context: context,
      title: 'جاري التحميل',
      message: 'يتم تحميل البيانات...',
      type: LoadingType.downloading,
    );
  }
}

class _LoadingDialogWidget extends StatefulWidget {
  final String title;
  final String message;
  final LoadingType type;

  const _LoadingDialogWidget({
    required this.title,
    required this.message,
    required this.type,
  });

  @override
  State<_LoadingDialogWidget> createState() => _LoadingDialogWidgetState();
}

class _LoadingDialogWidgetState extends State<_LoadingDialogWidget>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _dotsController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeIn),
    );

    _scaleController.forward();
    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
    _dotsController.repeat();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  Color _getPrimaryColor() {
    switch (widget.type) {
      case LoadingType.login:
        return AppColors.cartPurple;
      case LoadingType.register:
        return AppColors.primaryGreen;
      case LoadingType.loading:
        return AppColors.infoBlue;
      case LoadingType.processing:
        return AppColors.primaryOrange;
      case LoadingType.uploading:
        return AppColors.warningYellow;
      case LoadingType.downloading:
        return AppColors.infoBlue;
    }
  }

  Color _getSecondaryColor() {
    switch (widget.type) {
      case LoadingType.login:
        return AppColors.cartPurpleBorder;
      case LoadingType.register:
        return AppColors.successGreenBorder;
      case LoadingType.loading:
        return AppColors.infoBlueBorder;
      case LoadingType.processing:
        return AppColors.mediumYellow;
      case LoadingType.uploading:
        return AppColors.lightYellow;
      case LoadingType.downloading:
        return AppColors.infoBlueBorder;
    }
  }

  Color _getBackgroundColor() {
    switch (widget.type) {
      case LoadingType.login:
        return AppColors.cartPurpleBg;
      case LoadingType.register:
        return AppColors.successGreenBg;
      case LoadingType.loading:
        return AppColors.infoBlueBg;
      case LoadingType.processing:
        return AppColors.warningYellowBg;
      case LoadingType.uploading:
        return AppColors.warningYellowBg;
      case LoadingType.downloading:
        return AppColors.infoBlueBg;
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case LoadingType.login:
        return Icons.login_rounded;
      case LoadingType.register:
        return Icons.person_add_rounded;
      case LoadingType.loading:
        return Icons.hourglass_empty_rounded;
      case LoadingType.processing:
        return Icons.settings_rounded;
      case LoadingType.uploading:
        return Icons.cloud_upload_rounded;
      case LoadingType.downloading:
        return Icons.cloud_download_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 340),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Background with gradient
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.white,
                        _getBackgroundColor(),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: _getSecondaryColor().withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getPrimaryColor().withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      
                      // Title
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Message with animated dots
                      AnimatedBuilder(
                        animation: _dotsController,
                        builder: (context, child) {
                          int dotCount = (_dotsController.value * 3).floor() % 4;
                          String dots = '.' * dotCount;
                          return Text(
                            '${widget.message}$dots',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.black.withOpacity(0.7),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Progress Indicator
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outer rotating circle
                            AnimatedBuilder(
                              animation: _rotationController,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _rotationController.value * 6.28,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: SweepGradient(
                                        colors: [
                                          _getPrimaryColor(),
                                          _getSecondaryColor(),
                                          _getPrimaryColor().withOpacity(0.1),
                                        ],
                                        stops: const [0.0, 0.5, 1.0],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            
                            // Inner white circle
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _getPrimaryColor().withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                            
                            // Pulsing icon
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: 1.0 + (_pulseController.value * 0.15),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          _getPrimaryColor(),
                                          _getSecondaryColor(),
                                        ],
                                      ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: _getPrimaryColor().withOpacity(0.5),
                                          blurRadius: 15,
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
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Animated wave
                      SizedBox(
                        height: 40,
                        child: AnimatedBuilder(
                          animation: _rotationController,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: _WavePainter(
                                progress: _rotationController.value,
                                color: _getPrimaryColor(),
                              ),
                              size: const Size(double.infinity, 40),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Floating animated icon at top
                Positioned(
                  top: -30,
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_pulseController.value * 0.2),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _getPrimaryColor(),
                                _getSecondaryColor(),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: _getPrimaryColor().withOpacity(0.5),
                                blurRadius: 25,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Icon(
                            _getIcon(),
                            color: AppColors.white,
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // Floating particles
                ...List.generate(5, (index) {
                  return Positioned(
                    top: 50 + (index * 20.0),
                    right: index.isEven ? -10 : null,
                    left: index.isOdd ? -10 : null,
                    child: _FloatingParticle(
                      color: index.isEven
                          ? _getPrimaryColor()
                          : _getSecondaryColor(),
                      delay: index * 300,
                      size: 8 - (index * 0.5),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Wave Painter
class _WavePainter extends CustomPainter {
  final double progress;
  final Color color;

  _WavePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height / 2);

    for (double i = 0; i < size.width; i++) {
      path.lineTo(
        i,
        size.height / 2 +
            15 * math.sin((i / size.width * 2 * 3.14159) + (progress * 6.28)),
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Floating Particle
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
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

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
          offset: Offset(
            _animation.value * 30 - 15,
            _animation.value * 40 - 20,
          ),
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
                    color: widget.color.withOpacity(0.6),
                    blurRadius: 10,
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
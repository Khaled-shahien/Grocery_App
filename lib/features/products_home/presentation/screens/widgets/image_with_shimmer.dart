import 'package:flutter/material.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';
import 'package:shimmer/shimmer.dart';

class ImageWithShimmer extends StatefulWidget {
  final String imageUrl;

  const ImageWithShimmer({super.key, required this.imageUrl});

  @override
  State<ImageWithShimmer> createState() => _ImageWithShimmerState();
}

class _ImageWithShimmerState extends State<ImageWithShimmer> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive error state sizes
    final errorIconSize = (screenWidth * 0.1).clamp(30.0, 50.0);
    final errorTextSize = (screenWidth * 0.025).clamp(9.0, 12.0);
    final errorSpacing = screenWidth * 0.02;

    return Stack(
      children: [
        if (isLoading)
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.white,
            ),
          ),
        Image.network(
          widget.imageUrl,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    isLoading = false;
                  });
                }
              });
              return child;
            }
            return const SizedBox.shrink();
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.lightGray,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.broken_image,
                    size: errorIconSize,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: errorSpacing),
                  Text(
                    'Failed to load',
                    style: AppTextStyles.poppinsRegular.copyWith(
                      fontSize: errorTextSize,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
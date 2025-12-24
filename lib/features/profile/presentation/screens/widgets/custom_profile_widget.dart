import 'package:flutter/material.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';

/// A custom reusable profile widget that can be used throughout the app
///
/// This widget displays a profile item with an icon, title, and optional trailing widget.
/// It's designed to be flexible and reusable for various profile-related sections.
class CustomProfileWidget extends StatelessWidget {
  /// The icon to display at the start of the widget
  final IconData icon;

  /// The title text to display
  final String title;

  /// The subtitle text to display below the title (optional)
  final String? subtitle;

  /// The widget to display at the end of the row (optional)
  final Widget? trailing;

  /// The callback function when the widget is tapped
  final VoidCallback? onTap;

  /// Creates a custom profile widget
  ///
  /// The [icon] and [title] parameters are required.
  const CustomProfileWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: AppColors.white,
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryOrange, size: 24),
        title: Text(
          title,
          style: AppTextStyles.poppinsMedium.copyWith(
            fontSize: 16,
            color: AppColors.black,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: AppTextStyles.poppinsRegular.copyWith(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              )
            : null,
        trailing:
            trailing ??
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

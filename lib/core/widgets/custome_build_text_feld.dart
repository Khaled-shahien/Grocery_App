import 'package:flutter/material.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/core/theme/app_text_styles.dart';

Widget buildTextField(String hint, {bool isPassword = false, required controller, String? Function(String?)?  validator}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    validator: validator,
    style: AppTextStyles.poppinsRegular.copyWith(
      color: AppColors.black,
      fontSize: 14,
    ),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.poppinsRegular.copyWith(
        color: Colors.black.withOpacity(0.4),
        fontSize: 14,
      ),
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.mediumYellow,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.mediumYellow,
          width: 2,
        ),
      ),
    ),
  );
}

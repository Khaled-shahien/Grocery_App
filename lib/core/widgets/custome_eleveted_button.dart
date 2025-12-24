import 'package:flutter/material.dart';
import 'package:grocery_app/core/theme/app_colors.dart';

class CustomeElevatedButton extends StatelessWidget {
  const CustomeElevatedButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        minimumSize: Size(300, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(color: AppColors.darkYellow, width: 2),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
      ),
    );
  }
}

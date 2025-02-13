// constants.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// App Colors
class AppColors {
  static const Color primary = Color(0xFF4CAF50); // Green
  static const Color secondary = Color(0xFF8BC34A); // Light Green
  static const Color accent = Color(0xFFFFC107); // Amber
  static const Color background = Color(0xFFF5F5F5); // Light Gray
  static const Color text = Color(0xFF212121); // Dark Gray
  static const Color error = Color(0xFFD32F2F); // Red
}

// Font Styles
class AppFonts {
  static const String defaultFont = 'Roboto';
  static const TextStyle heading = TextStyle(
    fontFamily: defaultFont,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static const TextStyle body = TextStyle(
    fontFamily: defaultFont,
    fontSize: 16,
    color: AppColors.text,
  );
}

// Snackbar
void showCustomSnackbar(String message, {bool isError = false}) {
  Get.snackbar(
    isError ? 'Error' : 'Success',
    message,
    backgroundColor: isError ? AppColors.error : AppColors.primary,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 8,
    margin: EdgeInsets.all(12),
    duration: Duration(seconds: 3),
  );
}

// AppBar Theme
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppFonts.heading),
      backgroundColor: AppColors.primary,
      elevation: 4,
      shadowColor: Colors.black26,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

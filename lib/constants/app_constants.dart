import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xFF080B14);
  static const Color primaryColor = Color(0xFF7C3AED);
  static const Color secondaryColor = Color(0xFF2563EB);
  static const Color accentColor = Color(0xFFDB2777);
  static const Color successColor = Color(0xFF059669);
  static const Color cardColor = Color(0xFF0F172A);
  static const Color borderColor = Color(0xFF1E293B);
  static const Color textColor = Color(0xFF94A3B8);
  static const Color textLightColor = Color(0xFF475569);
}

class AppTextStyles {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 60, fontWeight: FontWeight.w900,
    color: Colors.white, letterSpacing: 10, height: 1,
  );
  
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w300,
    color: AppColors.textColor, letterSpacing: 14,
  );
  
  static const TextStyle buttonTextStyle = TextStyle(
    color: Colors.white, fontSize: 17,
    fontWeight: FontWeight.w800, letterSpacing: 3,
  );
}
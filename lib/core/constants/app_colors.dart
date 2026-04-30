import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color secondary = Color(0xFFEC4899); // Pink
  static const Color background = Color(0xFFF8FAFC);
  static const Color darkBackground = Color(0xFF0F172A);
  
  static const Color textBody = Color(0xFF334155);
  static const Color textHeadline = Color(0xFF1E293B);
  
  static const Gradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

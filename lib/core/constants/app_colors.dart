import 'package:flutter/material.dart';

class AppColors {
  // Primary — warm indigo, trustworthy but not cold
  static const Color primary = Color(0xFF2D3A8C);
  // Secondary — warm teal, action color
  static const Color secondary = Color(0xFF1A9E8F);
  // Status colors — cohesive warm family
  static const Color orange = Color(0xFFE8853A);
  static const Color purple = Color(0xFF9B59B6);
  static const Color completed = Color(0xFF1A9E8F);

  // Background — warm off-white instead of cold grey
  static const Color bg = Color(0xFFF7F6F3);
  // Surface — slightly warm white for cards
  static const Color surface = Color(0xFFFFFFFF);

  static const Color kora = Color(0xFF0062F6);

  static const Color error = Color(0xFFCF4444);
  // Text — softer than pure black
  static const Color text = Color(0xFF1A1D21);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color white = Color(0xFFFFFFFF);
  static const Color outline = Color(0xFFD1D5DB);
  static const Color grey = Color(0xFF9CA3AF);
  static const Color onboardingBg = Color(0xFF1E2A5E);
  static const Color shade100 = Color.fromRGBO(45, 58, 140, .12);

  // Escrow status tints — soft backgrounds
  static const Color pendingBg = Color(0xFFFEF3C7);
  static const Color pendingText = Color(0xFF92400E);
  static const Color completedBg = Color(0xFFD1FAE5);
  static const Color completedText = Color(0xFF065F46);
  static const Color canceledBg = Color(0xFFFEE2E2);
  static const Color canceledText = Color(0xFF991B1B);
  static const Color refundedBg = Color(0xFFEDE9FE);
  static const Color refundedText = Color(0xFF5B21B6);

  static MaterialColor mainColor =
      const MaterialColor(0xFF2D3A8C, <int, Color>{
    50: Color.fromRGBO(45, 58, 140, .06),
    100: Color.fromRGBO(45, 58, 140, .12),
    200: Color.fromRGBO(45, 58, 140, .2),
    300: Color.fromRGBO(45, 58, 140, .3),
    400: Color.fromRGBO(45, 58, 140, .4),
    500: Color(0xFF2D3A8C),
    600: Color.fromRGBO(45, 58, 140, .7),
    700: Color.fromRGBO(45, 58, 140, .8),
    800: Color.fromRGBO(45, 58, 140, .9),
    900: Color.fromRGBO(45, 58, 140, 1),
  });
}

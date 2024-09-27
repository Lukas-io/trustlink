import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF3252B3);
  static const Color bg = Color(0xFFF5F5F5);
  static const Color error = Color(0xFFD53833);
  static const Color text = Color(0xFF06090C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color outline = Color(0xFFA8A8A8);
  static const Color grey = Color(0xFF808080);
  static const Color onboardingBg = Color(0xFF283B73);

  static MaterialColor mainColor = const MaterialColor(
    0xFF3252B3,
    <int, Color>{
      // 50: Color(0xFFFFF3CC), // Very light yellow
      // 100: Color(0xFFFFE699), // Light yellow
      // 200: Color(0xFFFFD966), // Lighter yellow
      // 300: Color(0xFFFFCC33), // Light yellow
      // 400: Color(0xFFFFBF00), // Slightly darker yellow
      // 500: Color(0xFFFFCC2A), // Base yellow
      // 600: Color(0xFFE6B800), // Darker yellow
      // 700: Color(0xFFCC9900), // Even darker yellow
      // 800: Color(0xFFB37A00), // More darker yellow
      // 900: Color(0xFF805400), // Darkest yellow
    },
  );
}

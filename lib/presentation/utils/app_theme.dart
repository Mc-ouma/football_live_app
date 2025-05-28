import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors
  static const Color primaryColor = Colors.blue;
  static const Color secondaryColor = Colors.blueAccent;
  static const Color accentColor = Color(0xFF2962FF);

  // Background Colors
  static const Color scaffoldBackgroundColor = Colors.white;
  static const Color cardBackgroundColor = Colors.white;

  // Text Colors
  static const Color primaryTextColor = Colors.black87;
  static const Color secondaryTextColor = Colors.black54;
  static const Color disabledTextColor = Colors.black38;
  static const Color inverseTextColor = Colors.white;

  // Status Colors
  static const Color errorColor = Colors.redAccent;
  static const Color successColor = Colors.greenAccent;
  static const Color warningColor = Colors.orangeAccent;
  static const Color infoColor = Colors.blueAccent;

  // Custom Team Colors for visualization (used in stats charts, etc.)
  static const Color homeTeamColor = Color(0xFF1565C0); // Blue
  static const Color awayTeamColor = Color(0xFFD32F2F); // Red

  static ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        color: primaryColor,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        buttonColor: primaryColor,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: primaryTextColor,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: primaryTextColor,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: primaryTextColor,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: primaryTextColor,
        ),
        bodyMedium: TextStyle(
          color: secondaryTextColor,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF121212),
      appBarTheme: AppBarTheme(
        color: Color(0xFF1F1F1F),
        elevation: 0,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        color: Color(0xFF2C2C2C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        buttonColor: primaryColor,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: Colors.white70,
        ),
        bodyMedium: TextStyle(
          color: Colors.white60,
        ),
      ),
    );
  }
}

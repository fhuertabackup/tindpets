
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF5864); // Sunset Orange
  static const Color secondaryColor = Color(0xFF17B9FF); // Paw Blue
  static const Color accentColor = Color(0xFF42D07D); // Leaf Green
  static const Color backgroundColor = Color(0xFFF5F7FA);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.grey),
      ),
    );
  }
}

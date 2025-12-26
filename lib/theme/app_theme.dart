import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary Background Colors (from designs)
  static const Color darkGreen = Color(0xFF0D1F1A);  // Main dark green
  static const Color black = Color(0xFF000000);  // Pure black for login/signup
  static const Color lightBackground = Color(0xFFF5F5F5);  // Light gray for edit profile
  
  // Card & Surface Colors
  static const Color darkGreenCard = Color(0xFF1A2F2A);  // Card background
  static const Color darkGreenLight = Color(0xFF1A2E28);  // Lighter variant
  
  // Primary Accent
  static const Color neonGreen = Color(0xFF00FF85);  // Main accent green
  static const Color neonGreenDark = Color(0xFF00E676);  // Darker variant
  
  // Status Colors
  static const Color errorRed = Color(0xFFFF3B30);
  static const Color warningOrange = Color(0xFFFF9500);
  static const Color dangerRed = Color(0xFFFF3B30);
  static const Color successGreen = Color(0xFF34C759);
  
  // Text Colors
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGray = Color(0xFF8E8E93);  // iOS gray
  static const Color textLightGray = Color(0xFFAEAEB2);
  static const Color textDarkGray = Color(0xFF636366);
  
  // Category Colors (exact from designs)
  static const Color foodOrange = Color(0xFFFF9500);
  static const Color transportBlue = Color(0xFF007AFF);
  static const Color entertainmentPurple = Color(0xFF9747FF);
  static const Color booksBlue = Color(0xFF5E5CE6);
  static const Color booksGreen = Color(0xFF34C759);
  static const Color shoppingPink = Color(0xFFFF2D55);
  static const Color billsYellow = Color(0xFFFFCC00);
  static const Color rentBlue = Color(0xFF5856D6);
  static const Color groceriesOrange = Color(0xFFFF9500);
  static const Color housingPink = Color(0xFFFF2D55);
  
  // Text Styles using Inter font (from designs)
  static TextStyle get displayLarge => GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: textWhite,
        height: 1.2,
      );
      
  static TextStyle get displayMedium => GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: textWhite,
        height: 1.2,
      );
      
  static TextStyle get headingLarge => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textWhite,
      );
      
  static TextStyle get headingMedium => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textWhite,
      );
      
  static TextStyle get headingSmall => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textWhite,
      );
      
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        color: textWhite,
      );
      
  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        color: textGray,
      );
      
  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        color: textGray,
      );
      
  static TextStyle get buttonText => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: black,
      );
      
  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textWhite,
      );
}


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vasu/shared/constants/app_colors.dart';

class AppTheme {
  // Light theme
  static ThemeData lightTheme(double screenWidth) {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: AppColors.PrimaryColor,
        secondary: AppColors.SecondaryColor,
        background: Colors.white,
        surface: Colors.grey[100]!,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Colors.black,
        onSurface: Colors.black,
      ),
      primaryColor: AppColors.PrimaryColor,
      primaryTextTheme: TextTheme(
        bodyLarge: GoogleFonts.mulish(
            color: Colors.black, fontSize: screenWidth * 0.045), // 4.5%
        bodyMedium: GoogleFonts.mulish(
            color: Colors.black, fontSize: screenWidth * 0.04), // 4.0%
        bodySmall: GoogleFonts.mulish(
            color: Colors.black, fontSize: screenWidth * 0.035), // 3.5%
        displayLarge: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontSize: screenWidth * 0.065), // 6.5%
        displayMedium: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontSize: screenWidth * 0.055), // 5.5%
        displaySmall: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontSize: screenWidth * 0.05), // 5.0%
        headlineLarge: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.07), // 7.0%
        headlineMedium: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.06), // 6.0%
        headlineSmall: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.055), // 5.5%
        titleLarge: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.08), // 8.0%
        titleMedium: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.065), // 6.5%
        titleSmall: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045), // 5.0%
        labelLarge: GoogleFonts.mulish(
            color: Colors.black, fontSize: screenWidth * 0.045), // 4.5%
        labelMedium: GoogleFonts.mulish(
            color: Colors.black, fontSize: screenWidth * 0.04), // 4.0%
        labelSmall: GoogleFonts.mulish(
            color: Colors.black, fontSize: screenWidth * 0.035), // 3.5%
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.mulish(
            color: Colors.grey, fontSize: screenWidth * 0.045), // 4.5%
        bodyMedium: GoogleFonts.mulish(
            color: Colors.grey, fontSize: screenWidth * 0.04), // 4.0%
        bodySmall: GoogleFonts.mulish(
            color: Colors.grey, fontSize: screenWidth * 0.035), // 3.5%
        displayLarge: GoogleFonts.mulish(
            color: Colors.black, fontSize: screenWidth * 0.065), // 6.5%
        displayMedium: GoogleFonts.mulish(
            color: Colors.black, fontSize: screenWidth * 0.055), // 5.5%
        displaySmall: GoogleFonts.mulish(
            color: Colors.black, fontSize: screenWidth * 0.05), // 5.0%
        headlineLarge: GoogleFonts.mulish(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.07), // 7.0%
        headlineMedium: GoogleFonts.mulish(
            color: Colors.grey,
            fontWeight: FontWeight.w700,
            fontSize: screenWidth * 0.06), // 6.0%
        headlineSmall: GoogleFonts.mulish(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.055), // 5.5%
        titleLarge: GoogleFonts.mulish(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.08), // 8.0%
        titleMedium: GoogleFonts.mulish(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.065), // 6.5%
        titleSmall: GoogleFonts.mulish(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: screenWidth * 0.05), // 5.0%
        labelLarge: GoogleFonts.mulish(
            color: Colors.grey, fontSize: screenWidth * 0.045), // 4.5%
        labelMedium: GoogleFonts.mulish(
            color: Colors.grey, fontSize: screenWidth * 0.04), // 4.0%
        labelSmall: GoogleFonts.mulish(
            color: Colors.grey, fontSize: screenWidth * 0.035), // 3.5%
      ),
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        color: AppColors.PrimaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.PrimaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.PrimaryColor,
        actionTextColor: AppColors.BackgroundColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(GoogleFonts.mulish(
              fontSize: screenWidth * 0.045,
              color: Colors.white,
              fontWeight: FontWeight.bold)),
          foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
          backgroundColor:
              const WidgetStatePropertyAll<Color>(AppColors.PrimaryColor),
          minimumSize:
              const WidgetStatePropertyAll<Size>(Size(double.infinity, 56)),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 20.0),
          ),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }

  // Dark theme
  static ThemeData darkTheme(double screenWidth) {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        primary: AppColors.PrimaryColor,
        secondary: AppColors.SecondaryColor,
        background: Color(0xff262626),
        surface: Color(0xff181818),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Colors.white,
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: Color(0xff262626),
      primaryTextTheme: TextTheme(
        bodyLarge: GoogleFonts.mulish(
            color: Colors.white, fontSize: screenWidth * 0.045), // 4.5%
        bodyMedium: GoogleFonts.mulish(
            color: Colors.white, fontSize: screenWidth * 0.04), // 4.0%
        bodySmall: GoogleFonts.mulish(
            color: Colors.white, fontSize: screenWidth * 0.035), // 3.5%
        displayLarge: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontSize: screenWidth * 0.065), // 6.5%
        displayMedium: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontSize: screenWidth * 0.055), // 5.5%
        displaySmall: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontSize: screenWidth * 0.45), // 5.0%
        headlineLarge: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.bold), // 7.0%
        headlineMedium: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.06), // 6.0%
        headlineSmall: GoogleFonts.mulish(
            fontWeight: FontWeight.bold,
            color: AppColors.PrimaryColor,
            fontSize: screenWidth * 0.055), // 5.5%
        titleLarge: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.08), // 8.0%
        titleMedium: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.065), // 6.5%
        titleSmall: GoogleFonts.mulish(
            color: AppColors.PrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045), // 5.0%
        labelLarge: GoogleFonts.mulish(
            color: Colors.white, fontSize: screenWidth * 0.045), // 4.5%
        labelMedium: GoogleFonts.mulish(
            color: Colors.white, fontSize: screenWidth * 0.04), // 4.0%
        labelSmall: GoogleFonts.mulish(
            color: Colors.white, fontSize: screenWidth * 0.035), // 3.5%
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.mulish(
            color: Colors.grey, fontSize: screenWidth * 0.045), // 4.5%
        bodyMedium: GoogleFonts.mulish(
            color: Colors.grey, fontSize: screenWidth * 0.04), // 4.0%
        bodySmall: GoogleFonts.mulish(
            color: Colors.grey, fontSize: screenWidth * 0.035), // 3.5%
        displayLarge: GoogleFonts.mulish(
            color: Colors.white, fontSize: screenWidth * 0.065), // 6.5%
        displayMedium: GoogleFonts.mulish(
            color: Colors.white, fontSize: screenWidth * 0.055), // 5.5%
        displaySmall: GoogleFonts.mulish(
            color: Colors.white, fontSize: screenWidth * 0.05), // 5.0%
        headlineLarge: GoogleFonts.mulish(
            color: Colors.grey,
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.bold), // 7.0%
        headlineMedium: GoogleFonts.mulish(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.06), // 6.0%
        headlineSmall: GoogleFonts.mulish(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontSize: screenWidth * 0.055), // 5.5%
        titleLarge: GoogleFonts.mulish(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.08), // 8.0%
        titleMedium: GoogleFonts.mulish(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.065), // 6.5%
        titleSmall: GoogleFonts.mulish(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05), // 5.0%
        labelLarge: GoogleFonts.mulish(
            color: Colors.white, fontSize: screenWidth * 0.045), // 4.5%
        labelMedium: GoogleFonts.mulish(
            color: Colors.white, fontSize: screenWidth * 0.04), // 4.0%
        labelSmall: GoogleFonts.mulish(
            color: Colors.white, fontSize: screenWidth * 0.035), // 3.5%
      ),
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.black,
        textTheme: ButtonTextTheme.primary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.BackgroundColor,
        actionTextColor: AppColors.PrimaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll<Color>(Colors.black),
          textStyle: WidgetStatePropertyAll(GoogleFonts.mulish(
              fontSize: screenWidth * 0.05,
              color: Colors.black,
              fontWeight: FontWeight.bold)),
          backgroundColor:
              const WidgetStatePropertyAll<Color>(AppColors.PrimaryColor),
          minimumSize:
              const WidgetStatePropertyAll<Size>(Size(double.infinity, 56)),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 20.0),
          ),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }
}

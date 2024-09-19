import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static Brightness mode(BuildContext context) {
    if (Theme.of(context).brightness.isDark) {
      return Brightness.dark;
    }
    return Brightness.light;
  }

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,
    canvasColor: AppColors.lightBackgroundColor,
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    buttonTheme: const ButtonThemeData(buttonColor: AppColors.primaryColor),
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme:
        const AppBarTheme(backgroundColor: AppColors.lightBackgroundColor),
    useMaterial3: true,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,
    canvasColor: AppColors.darkBackgroundColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    buttonTheme: const ButtonThemeData(buttonColor: AppColors.primaryColor),
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme:
        const AppBarTheme(backgroundColor: AppColors.darkBackgroundColor),
    useMaterial3: true,
  );
}

class AppTextStyles {
  static const TextStyle boldLarge = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle boldMedium = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle medium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle regularSmall = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle regularTiny = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
}

extension BrightnessX on Brightness {
  bool get isDark => this == Brightness.dark;
  bool get isLight => this == Brightness.light;
}

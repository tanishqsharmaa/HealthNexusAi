import 'package:flutter/material.dart';
import 'colors.dart'; // Import the colors defined in colors.dart
import 'text_styles.dart'; // Import the text styles defined in text_styles.dart

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondaryContainer: AppColors.secondary,
      error: AppColors.error,
    ),
    canvasColor: AppColors.background,
    scaffoldBackgroundColor: AppColors.background,
    dividerColor: AppColors.divider,
    shadowColor: AppColors.shadow,
    appBarTheme: AppBarTheme(
      color: AppColors.primary,
      titleTextStyle: AppTextStyles.heading2.copyWith(color: AppColors.onPrimary),
      iconTheme: const IconThemeData(color: AppColors.onPrimary),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading1,
      displayMedium: AppTextStyles.heading2,
      displaySmall: AppTextStyles.heading3,
      titleMedium: AppTextStyles.subtitle1,
      titleSmall: AppTextStyles.subtitle2,
      bodyLarge: AppTextStyles.bodyText1,
      bodyMedium: AppTextStyles.bodyText2,
      labelSmall: AppTextStyles.caption,
      labelLarge: AppTextStyles.button,
      labelMedium: AppTextStyles.overline,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.gray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.error),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryVariant,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondaryContainer: AppColors.secondaryVariant,
      error: AppColors.error,
    ),
    canvasColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    dividerColor: AppColors.grayDark,
    shadowColor: Colors.black45,
    appBarTheme: AppBarTheme(
      color: AppColors.primaryVariant,
      titleTextStyle: AppTextStyles.heading2.copyWith(color: AppColors.onPrimary),
      iconTheme: const IconThemeData(color: AppColors.onPrimary),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryVariant,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading1.copyWith(color: AppColors.onBackground),
      displayMedium: AppTextStyles.heading2.copyWith(color: AppColors.onBackground),
      displaySmall: AppTextStyles.heading3.copyWith(color: AppColors.onBackground),
      titleMedium: AppTextStyles.subtitle1.copyWith(color: AppColors.onBackground),
      titleSmall: AppTextStyles.subtitle2.copyWith(color: AppColors.onBackground),
      bodyLarge: AppTextStyles.bodyText1.copyWith(color: AppColors.onBackground),
      bodyMedium: AppTextStyles.bodyText2.copyWith(color: AppColors.onBackground),
      labelSmall: AppTextStyles.caption.copyWith(color: AppColors.grayLight),
      labelLarge: AppTextStyles.button.copyWith(color: AppColors.onPrimary),
      labelMedium: AppTextStyles.overline.copyWith(color: AppColors.grayLight),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grayDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.gray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.secondary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.error),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryVariant,
      foregroundColor: AppColors.onPrimary,
    ),
  );
}
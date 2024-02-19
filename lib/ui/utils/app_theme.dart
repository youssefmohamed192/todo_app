import 'package:flutter/material.dart';
import 'package:todo_app/ui/utils/app_colors.dart';

abstract class AppTheme {
  static const TextStyle appBarTextStyle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white);
  static const TextStyle taskTittleTextStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary);
  static const TextStyle taskDescriptionTextStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.lightBlack);
  static const TextStyle bottomSheetTittleTextStyle = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.black);

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      color: AppColors.primary,
      elevation: 0,
      titleTextStyle: appBarTextStyle,
    ),
    scaffoldBackgroundColor: AppColors.accent,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(size: 32),
      unselectedIconTheme: IconThemeData(size: 32),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: StadiumBorder(side: BorderSide(color: AppColors.white, width: 4)),
    ),
    dividerTheme: const DividerThemeData(thickness: 3, color: AppColors.primary)
  );
}

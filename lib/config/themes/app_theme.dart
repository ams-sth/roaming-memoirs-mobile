import 'package:flutter/material.dart';
import 'package:travel_log/config/constants/app_color_constant.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme() {
    return ThemeData(
      // colorScheme:
      //     const ColorScheme.light(primary: AppColorConstant.primarycolor),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColorConstant.appbarcolor,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColorConstant.bottomnavcolor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColorConstant.elevatedbutton),
        ),
      ),
    );
  }
}

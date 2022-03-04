import 'package:flutter/material.dart';
import './themes.dart';

class AppThemes {
  AppThemes._();

  static const double appPaddingVal = 16;

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.catalinaBlue,
    platform: TargetPlatform.android,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: AppTextStyle.headline4.copyWith(
        fontWeight: FontWeight.w500,
        color: Colors.white
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: AppTextStyle.subtitle1.copyWith(
        fontWeight: FontWeight.w500,
      ),
      // indicatorSize: TabBarIndicatorSize.label,
      labelColor: AppColors.catalinaBlue,
     /*  labelPadding:
          const EdgeInsets.symmetric(horizontal: AppThemes.appPaddingVal), */
      unselectedLabelColor: AppColors.oldSilver,
      unselectedLabelStyle: AppTextStyle.subtitle1.copyWith(
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: TextTheme(
      bodyText1: AppTextStyle.bodyText1,
      bodyText2: AppTextStyle.bodyText2,
      subtitle2: AppTextStyle.subtitle2,
      caption: AppTextStyle.caption,
      subtitle1: AppTextStyle.subtitle1,
      headline5: AppTextStyle.headline5,
      headline6: AppTextStyle.headline6,
      button: AppTextStyle.button,
      headline4: AppTextStyle.headline4,
    ),
    colorScheme: const ColorScheme(
      primary: AppColors.catalinaBlue,
      primaryContainer: AppColors.catalinaBlue,
      secondary: AppColors.catalinaBlue,
      secondaryContainer: Colors.transparent,
      surface: Color(0xFFC4C4C4),
      background: Color(0xFFE3E5E5),
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: AppColors.catalinaBlue,
      onSurface: Colors.black,
      onBackground: AppColors.catalinaBlue,
      onError: AppColors.catalinaBlue,
      brightness: Brightness.light,
    ),
  );
}

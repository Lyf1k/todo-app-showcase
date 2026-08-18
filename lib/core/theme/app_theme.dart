import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

extension AppTextTheme on TextTheme {
  TextStyle get display => displayLarge!;
  TextStyle get title => titleLarge!;
  TextStyle get body => bodyLarge!;
  TextStyle get label => labelLarge!;
  TextStyle get caption => labelSmall!;
}

class AppTheme {
  static _border([Color color = AppColors.outline]) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: color),
      borderRadius: BorderRadius.all(Radius.circular(24)),
    );
  }

  static final themeDataLight = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      titleTextStyle: appTextTheme.headlineLarge,
      iconTheme: IconThemeData(color: AppColors.primary),
      actionsIconTheme: IconThemeData(color: AppColors.primary),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: CircleBorder(),
    ),
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      surface: AppColors.surfaceVariant,
    ),
    textTheme: appTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadiusGeometry.circular(18),
        ),

        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        disabledForegroundColor: AppColors.onPrimary,
        disabledBackgroundColor: Colors.grey,
        textStyle: appTextTheme.bodyLarge,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      enabledBorder: _border(const Color.fromRGBO(209, 197, 181, 1)),
      focusedBorder: _border(),
      errorBorder: _border(AppColors.error),
      focusedErrorBorder: _border(),
      errorStyle: TextStyle(color: AppColors.error),

      disabledBorder: _border(const Color.fromARGB(255, 206, 202, 198)),
      hintStyle: appTextTheme.bodyLarge!.copyWith(
        color: const Color.fromRGBO(209, 197, 181, 1),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColors.onWarning,
      backgroundColor: const Color.fromARGB(50, 216, 201, 175),
      labelTextStyle: WidgetStateProperty.all(
        TextStyle(
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
          height: 1.4,
          fontSize: 14,
        ),
      ),
      iconTheme: iconThemeDataWidgetState,
      // selectedLabelStyle: appTextTheme.labelSmall?.copyWith(inherit: false),
      // unselectedLabelStyle: appTextTheme.labelSmall?.copyWith(inherit: false),
    ),
  );

  static final iconThemeDataWidgetState = WidgetStateProperty.fromMap(
    <WidgetStatesConstraint, IconThemeData>{
      WidgetState.pressed | WidgetState.hovered | WidgetState.dragged:
          IconThemeData(color: AppColors.success),
      // WidgetState.focused: IconThemeData(color: AppColors.error),
      WidgetState.any: IconThemeData(color: AppColors.onSuccess),
    },
  );

  static final appTextTheme = TextTheme().copyWith(
    displayLarge: TextStyle(
      fontFamily: 'Acme',
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
      height: 1.4,
      fontSize: 28,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Acme',
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.4,
      fontSize: 20,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Acme',
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
      height: 1.4,
      fontSize: 16,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Acme',
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
      height: 1.4,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Acme',
      fontWeight: FontWeight.normal,
      color: AppColors.textSecondary,
      height: 1.4,
      fontSize: 12,
    ),
  );

  // ---------------- DARK THEME ----------------
  static final themeDataDark = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      centerTitle: true,
      titleTextStyle: appTextThemeDark.headlineLarge,
      iconTheme: IconThemeData(color: AppColors.primaryDark),
      actionsIconTheme: IconThemeData(color: AppColors.primaryDark),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: CircleBorder(),
    ),
    scaffoldBackgroundColor: AppColors.surfaceVariantDark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
      surface: AppColors.backgroundDark,
    ),
    textTheme: appTextThemeDark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadiusGeometry.circular(18),
        ),
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.onPrimaryDark,
        disabledForegroundColor: AppColors.onPrimaryDark,
        disabledBackgroundColor: Colors.grey.shade800,
        textStyle: appTextThemeDark.bodyLarge,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      enabledBorder: _border(const Color.fromRGBO(90, 80, 70, 1)),
      focusedBorder: _border(AppColors.primaryDark),
      errorBorder: _border(AppColors.errorDark),
      focusedErrorBorder: _border(AppColors.errorDark),
      errorStyle: TextStyle(color: AppColors.errorDark),
      disabledBorder: _border(const Color.fromARGB(255, 60, 58, 56)),
      hintStyle: appTextThemeDark.bodyLarge!.copyWith(
        color: const Color.fromRGBO(150, 140, 130, 1),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: AppColors.surfaceVariant,
      backgroundColor: const Color.fromARGB(50, 40, 38, 35),
      labelTextStyle: WidgetStateProperty.all(
        TextStyle(
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondaryDark,
          height: 1.4,
          fontSize: 14,
        ),
      ),
      iconTheme: iconThemeDataWidgetStateDark,
    ),
  );

  static final iconThemeDataWidgetStateDark =
      WidgetStateProperty.fromMap(<WidgetStatesConstraint, IconThemeData>{
        WidgetState.pressed | WidgetState.hovered | WidgetState.dragged:
            IconThemeData(color: AppColors.successDark),
        WidgetState.any: IconThemeData(color: AppColors.onPrimaryDark),
      });

  static final appTextThemeDark = TextTheme().copyWith(
    displayLarge: TextStyle(
      fontFamily: 'Acme',
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimaryDark,
      height: 1.4,
      fontSize: 28,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Acme',
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
      height: 1.4,
      fontSize: 20,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Acme',
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimaryDark,
      height: 1.4,
      fontSize: 16,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Acme',
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondaryDark,
      height: 1.4,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Acme',
      fontWeight: FontWeight.normal,
      color: AppColors.textSecondaryDark,
      height: 1.4,
      fontSize: 12,
    ),
  );
}

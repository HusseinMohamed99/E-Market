import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_marko/shared/enum/enum.dart';
import 'package:super_marko/shared/styles/colors.dart';

final getThemeData = {
  AppTheme.lightTheme: ThemeData(
    scaffoldBackgroundColor: AppMainColors.whiteColor,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppMainColors.whiteColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: AppMainColors.whiteColor,
      elevation: 1,
      titleTextStyle: GoogleFonts.roboto(
        color: AppMainColors.greyDarkColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: AppMainColors.greyDarkColor,
        size: 24.sp,
      ),
      actionsIconTheme: IconThemeData(
        color: AppMainColors.greyDarkColor,
        size: 24.sp,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppMainColors.orangeColor,
      unselectedItemColor: AppMainColors.greyDarkColor,
      backgroundColor: AppMainColors.greyDarkColor,
      elevation: 25.0,
      unselectedIconTheme: IconThemeData(
        color: AppMainColors.greyDarkColor,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
        color: AppMainColors.greyDarkColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: GoogleFonts.roboto(
        color: AppMainColors.greyDarkColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: AppMainColors.greyDarkColor,
        fontWeight: FontWeight.w500,
      ),
      displayLarge: GoogleFonts.roboto(
        color: AppMainColors.greyDarkColor,
      ),
      displayMedium: GoogleFonts.roboto(
        color: AppMainColors.greyDarkColor,
      ),
      displaySmall: GoogleFonts.roboto(
        color: AppMainColors.greyDarkColor,
        fontWeight: FontWeight.bold,
        fontSize: 40.sp,
      ),
      headlineMedium: GoogleFonts.roboto(
        color: AppMainColors.greyDarkColor,
      ),
      headlineSmall: GoogleFonts.roboto(
        color: AppMainColors.greyDarkColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.roboto(
        color: AppMainColors.greyDarkColor,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: AppMainColors.greyDarkColor,
      ),
    ),
  ),
  AppTheme.darkTheme: ThemeData(
    cardColor: AppColorsDark.primaryDarkColor,
    scaffoldBackgroundColor: AppColorsDark.primaryDarkColor,
    primarySwatch: Colors.orange,
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColorsDark.primaryDarkColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: AppColorsDark.primaryDarkColor,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: AppMainColors.whiteColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: IconThemeData(
        color: AppMainColors.whiteColor,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppMainColors.orangeColor,
      unselectedItemColor: AppMainColors.whiteColor,
      backgroundColor: AppMainColors.greyDarkColor,
      elevation: 25.0,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
        color: AppMainColors.whiteColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: GoogleFonts.roboto(
        color: AppMainColors.whiteColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: AppMainColors.whiteColor,
        fontWeight: FontWeight.w500,
      ),
      displayLarge: GoogleFonts.roboto(
        color: AppMainColors.whiteColor,
      ),
      displayMedium: GoogleFonts.roboto(
        color: AppMainColors.whiteColor,
      ),
      displaySmall: GoogleFonts.roboto(
        color: AppMainColors.whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 40.sp,
      ),
      headlineMedium: GoogleFonts.roboto(
        color: AppMainColors.whiteColor,
      ),
      headlineSmall: GoogleFonts.roboto(
        color: AppMainColors.whiteColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.roboto(
        color: AppMainColors.whiteColor,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: AppMainColors.whiteColor,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppMainColors.whiteColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.roboto(
        color: AppMainColors.whiteColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: GoogleFonts.roboto(
        color: AppMainColors.whiteColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppMainColors.whiteColor,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppMainColors.whiteColor,
        ),
      ),
    ),
  ),
};

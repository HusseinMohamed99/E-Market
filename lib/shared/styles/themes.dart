import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_marko/shared/enum/enum.dart';
import 'package:super_marko/shared/styles/colors.dart';

final getThemeData = {
  AppTheme.lightTheme: ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 25.0,
      unselectedIconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      displayLarge: GoogleFonts.roboto(
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.roboto(
        color: Colors.white,
      ),
      displaySmall: GoogleFonts.roboto(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40.sp,
      ),
      headlineMedium: GoogleFonts.roboto(
        color: Colors.white,
      ),
      headlineSmall: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.roboto(
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: Colors.white,
      ),
    ),
  ),
  AppTheme.darkTheme: ThemeData(
    cardColor: AppColorsDark.primaryDarkColor,
    scaffoldBackgroundColor: AppColorsDark.primaryDarkColor,
    primarySwatch: Colors.deepOrange,
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF241056),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: Color(0xFF20123c),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrangeAccent,
      unselectedItemColor: Colors.white,
      backgroundColor: Color(0xFF121212),
      elevation: 25.0,
    ),
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.roboto(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: GoogleFonts.roboto(
        color: Colors.white,
      ),
      displayLarge: GoogleFonts.roboto(
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.roboto(
        color: Colors.white,
      ),
      displaySmall: GoogleFonts.roboto(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40.sp,
      ),
      headlineMedium: GoogleFonts.roboto(
        color: Colors.white,
      ),
      headlineSmall: GoogleFonts.roboto(
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.roboto(
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
    ),
  ),
};

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mego_market/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  cardColor: Color(0xFF20123c),
  scaffoldBackgroundColor: Color(0xFF20123c),
  primarySwatch: DColor,
  appBarTheme: AppBarTheme(
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
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrangeAccent,
    unselectedItemColor: Colors.white,
    backgroundColor: Color(0xFF121212),
    elevation: 25.0,
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    headline6: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: Colors.white,
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
    headline5: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.0),
    bodyText1: TextStyle(
      fontSize: 18.0,
      color: Colors.white,
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    hintStyle: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: DColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: DColor,
    unselectedItemColor: Colors.black,
    backgroundColor: Colors.white,
    elevation: 25.0,
    unselectedIconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.3,
    ),
  ),
);

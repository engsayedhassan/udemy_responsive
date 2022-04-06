import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'color.dart';

ThemeData darkTheme =ThemeData(
  primarySwatch: defualtColor,
  scaffoldBackgroundColor: HexColor('333537'),
  /*floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor:defualtColor,
  ),*/
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333537'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333537'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defualtColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333537'),
    elevation: 40,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
  ),
  fontFamily: 'PinkChicken',
);
////////////////////////////////////////////////////////
ThemeData lightTheme = ThemeData(
  primarySwatch: defualtColor,
  /*floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defualtColor,
  ),*/
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defualtColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    elevation: 40,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'PinkChicken',
);
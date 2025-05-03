import 'package:flutter/material.dart';

final ThemeData socratizeTheme = ThemeData(
  primaryColor: Color(0xff1977d2),
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: Color(0xfffff9e3),
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
  ),
  searchBarTheme: SearchBarThemeData(
    backgroundColor: WidgetStateProperty.all(Colors.white),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Color(0xff1977d2)),
      ),
    ),
  ),
);

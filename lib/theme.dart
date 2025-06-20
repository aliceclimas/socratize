import 'package:flutter/material.dart';

final ThemeData socratizeTheme = ThemeData(
  primaryColor: Color.fromARGB(255, 151, 159, 167),
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: Color(0xffFFFCF2),
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
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffFFFCF2),
    centerTitle: true,

  ),
);

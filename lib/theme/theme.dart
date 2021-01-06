import 'package:bakery/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

ThemeData kLightTheme = ThemeData(
  primaryColor: kPrimaryColor,
  accentColor: kPrimaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      button: TextStyle(fontSize: 16, letterSpacing: 0.5),
      // h1
      headline5: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: kPrimaryTextColor,
      ),
      // h2
      headline6: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: kPrimaryTextColor,
      ),
      // body med
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: kSecondaryTextColor,
      ),
      // body norm - med
      bodyText2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: kSecondaryTextColor,
      ),
      // body norm - reg
      subtitle1: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: kPrimaryColor,
      ),
      // body small
      subtitle2: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: kPrimaryTextColor,
      ),
      caption: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: kSecondaryTextColor,
      )),
  scaffoldBackgroundColor: kBackgroundColor,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: kPrimaryColor,
    height: 44,
    textTheme: ButtonTextTheme.primary,
  ),
);

ThemeData kDarkTheme = ThemeData.dark().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: ThemeData.dark()
      .textTheme
      .apply(fontFamily: GoogleFonts.poppins().fontFamily),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.grey[900],
    height: 44,
    textTheme: ButtonTextTheme.primary,
  ),
);

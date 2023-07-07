import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/util/export.dart';

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
  // context.theme. instead of Theme.of(context)
}

ThemeData kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: const Color(0xFF4298B5),
  secondaryHeaderColor: const Color.fromRGBO(30, 30, 31, 1),
  scaffoldBackgroundColor: const Color.fromRGBO(5, 7, 20, 1),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(5, 7, 20, 1),
    elevation: 0,
  ),
  fontFamily: GoogleFonts.nunito().fontFamily,
  textTheme: const TextTheme(
    // for the text in on bording
    displayLarge: TextStyle(
      fontSize: 37,
      fontWeight: FontWeight.w800,
      color: Color.fromRGBO(221, 217, 221, 1),
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: Color.fromRGBO(221, 217, 221, 1),
    ),
    displaySmall: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(221, 217, 221, 1),
    ),
    // every label is for  button
    labelLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(221, 217, 221, 1),
    ),
    labelMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(221, 217, 221, 1),
    ),
    labelSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(221, 217, 221, 1),
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(221, 217, 221, 1),
    ),
    bodyMedium: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(170, 166, 170, 1),
    ),
    bodySmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(170, 166, 170, 1),
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Color.fromRGBO(170, 166, 170, 1),
    ),
  ),
  //
  //
  //
  iconTheme: const IconThemeData(
    color: Color.fromRGBO(221, 217, 221, 1),
    weight: 500.0,
    size: 30,
  ),
  //
  //
  //
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF4298B5),
    behavior: SnackBarBehavior.floating,
    contentTextStyle:
        TextStyle(fontSize: 14.0, color: Color.fromRGBO(255, 255, 255, 1)),
  ),
  //
  //
  //
  expansionTileTheme: const ExpansionTileThemeData(
    iconColor: Color(0xFF4298B5),
  ),
  //
  //
  //
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(66, 152, 181, 1),
      foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.0.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      alignment: Alignment.center,
    ),
  ),
  //
  //
  //

  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(const Color.fromRGBO(5, 7, 20, 1)),
    fillColor: MaterialStateProperty.all(
      const Color(0xFF4298B5),
    ),
    shape: const CircleBorder(),
  ),

  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFF4298B5),
    selectionColor: Color(0xFF4298B5),
    selectionHandleColor: Color(0xFF4298B5),
  ),
);

ThemeData kLightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  primaryColor: const Color(0xFF4298B5),
  secondaryHeaderColor: const Color.fromRGBO(170, 170, 170, 1),
  scaffoldBackgroundColor: const Color.fromRGBO(221, 217, 221, 1),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(221, 217, 221, 1),
    elevation: 0,
  ),
  fontFamily: GoogleFonts.nunito().fontFamily,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 37,
      fontWeight: FontWeight.w800,
      color: Color.fromRGBO(5, 7, 20, 1),
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: Color.fromRGBO(5, 7, 20, 1),
    ),
    displaySmall: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(5, 7, 20, 1),
    ),
    labelLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(5, 7, 20, 1),
    ),
    labelMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(5, 7, 20, 1),
    ),
    labelSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(5, 7, 20, 1),
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(5, 7, 20, 1),
    ),
    bodyMedium: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(34, 34, 34, 1),
    ),
    bodySmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(34, 34, 34, 1),
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Color.fromRGBO(34, 34, 34, 1),
    ),
  ),

  //
  //
  //
  iconTheme: const IconThemeData(
    color: Color.fromRGBO(5, 7, 20, 1),
    weight: 500.0,
    size: 30,
  ),
  //
  //
  //
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF4298B5),
    behavior: SnackBarBehavior.floating,
    contentTextStyle:
        TextStyle(fontSize: 14.0, color: Color.fromRGBO(0, 0, 0, 1)),
  ),
  //
  //
  //
  expansionTileTheme: const ExpansionTileThemeData(
    iconColor: Color(0xFF4298B5),
  ),
  //
  //
  //
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(66, 152, 181, 1),
      foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.0.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      alignment: Alignment.center,
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(
      const Color.fromRGBO(221, 217, 221, 1),
    ),
    fillColor: MaterialStateProperty.all(
      const Color(0xFF4298B5),
    ),
    shape: const CircleBorder(),
  ),
   textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFF4298B5),
    selectionColor: Color(0xFF4298B5),
    selectionHandleColor: Color(0xFF4298B5),
  ),
);

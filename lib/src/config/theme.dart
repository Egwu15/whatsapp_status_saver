import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: Colors.grey[200],
    primaryColor: Colors.green[900],
    primarySwatch: Colors.green,
    inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(), labelStyle: GoogleFonts.heebo()),
    textTheme: TextTheme(
      headline1: GoogleFonts.barlowSemiCondensed(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: GoogleFonts.heebo(
        fontSize: 16,
      ),
      headline3: GoogleFonts.barlowSemiCondensed(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[900]?.withOpacity(0.8),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    listTileTheme: const ListTileThemeData(iconColor: Colors.green));

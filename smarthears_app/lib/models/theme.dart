import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const secondaryColor = Color(0xFFD3AF5F);
const secondaryVariantColor = Color(0xFFc29017);
const onsecondaryColor = Color(0xFF2a2a2a);
const primaryColor = Color(0xFF2a2a2a);
const primaryVariantColor = Color(0xff6C6C6C);
const onPrimaryColor = Color(0xffdedede);
const backgroundColor = Color(0xff111111);
const onBackgroundColor = Color(0xffdedede);
const surfaceColor = Color(0xff242424);
const onSurfacesColor = Color(0xffdedede);
const textColor = Color(0xffdedede);
const errorColor = Color(0xfff44336);
const onErrorColor = Color(0xFF2a2a2a);
const boxShadowColor = Color.fromRGBO(114, 114, 109, 0.8);

Map<int, Color> color = {
  50: const Color.fromRGBO(211, 175, 95, 1),
  100: const Color.fromRGBO(211, 175, 95, .9),
  200: const Color.fromRGBO(211, 175, 95, .8),
  300: const Color.fromRGBO(211, 175, 95, .7),
  400: const Color.fromRGBO(211, 175, 95, .6),
  500: const Color.fromRGBO(211, 175, 95, .5),
  600: const Color.fromRGBO(211, 175, 95, .4),
  700: const Color.fromRGBO(211, 175, 95, .3),
  800: const Color.fromRGBO(211, 175, 95, 0.2),
  900: const Color.fromRGBO(211, 175, 95, .1)
};

Map<int, Color> swatch = {
  50: const Color.fromRGBO(42, 42, 42, .1),
  100: const Color.fromRGBO(42, 42, 42, .2),
  200: const Color.fromRGBO(42, 42, 42, .3),
  300: const Color.fromRGBO(42, 42, 42, 0.4),
  400: const Color.fromRGBO(42, 42, 42, .5),
  500: const Color.fromRGBO(42, 42, 42, .6),
  600: const Color.fromRGBO(42, 42, 42, .7),
  700: const Color.fromRGBO(42, 42, 42, .8),
  800: const Color.fromRGBO(42, 42, 42, .9),
  900: const Color.fromRGBO(42, 42, 42, 1)
};

final ThemeData theme = ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
        focusColor: backgroundColor,
        focusedBorder: OutlineInputBorder(),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(),
        disabledBorder: OutlineInputBorder(),
        labelStyle: TextStyle(color: primaryColor)),
    colorScheme: const ColorScheme(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        error: errorColor,
        onPrimary: onPrimaryColor,
        onSecondary: onsecondaryColor,
        onSurface: onSurfacesColor,
        onBackground: onBackgroundColor,
        onError: onErrorColor,
        brightness: Brightness.dark),
    brightness: Brightness.dark,
    primaryColor: const Color.fromRGBO(30, 30, 30, 1),
    primarySwatch: MaterialColor(0xFF424242, swatch),
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    splashColor: const Color.fromRGBO(30, 30, 30, 1),
    shadowColor: const Color.fromRGBO(30, 30, 30, 1),
    textSelectionTheme: TextSelectionThemeData(cursorColor: MaterialColor(0xFFD3AF5F, color)),
    fontFamily: 'Roboto',
    textTheme: TextTheme(
        headline1: const TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: GoogleFonts.robotoCondensed(textStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white70)),
        bodyText1: GoogleFonts.robotoCondensed(textStyle: const TextStyle(fontSize: 15.0)),
        headline3: TextStyle(fontFamily: 'OpenSans', fontSize: 45.0, color: MaterialColor(0xFFD3AF5F, color)),
        button: const TextStyle(fontFamily: 'OpenSans'),
        subtitle1: GoogleFonts.robotoCondensed(),
        bodyText2: GoogleFonts.robotoCondensed(),
        headline5: GoogleFonts.robotoCondensed(textStyle: const TextStyle(fontFamily: '', fontSize: 20.0, color: Colors.white70)),
        headline4: GoogleFonts.robotoCondensed(textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(211, 175, 95, 1), elevation: 8, minimumSize: const Size(250, 60))));

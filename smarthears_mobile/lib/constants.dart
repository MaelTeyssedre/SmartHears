import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorSet {
  static const Color secondaryColor = Color(0xFFD3AF5F);
  static const Color secondaryVariantColor = Color(0xFFc29017);
  static const Color onSecondaryColor = Color(0xFF2a2a2a);
  static const Color primaryColor = Color(0xFF2a2a2a);
  static const Color primaryVariantColor = Color(0xff6C6C6C);
  static const Color onPrimaryColor = Color(0xffdedede);
  static const Color backgroundColor = Color(0xff111111);
  static const Color onBackgroundColor = Color(0xffdedede);
  static const Color surfaceColor = Color(0xff242424);
  static const Color onSurfacesColor = Color(0xffdedede);
  static const Color textColor = Color(0xffdedede);
  static const Color errorColor = Color(0xfff44336);
  static const Color onErrorColor = Color(0xFF2a2a2a);
  static const Color boxShadowColor = Color.fromRGBO(114, 114, 109, 0.8);
  static const Map<int, Color> color = {
    50: Color.fromRGBO(211, 175, 95, 1),
    100: Color.fromRGBO(211, 175, 95, .9),
    200: Color.fromRGBO(211, 175, 95, .8),
    300: Color.fromRGBO(211, 175, 95, .7),
    400: Color.fromRGBO(211, 175, 95, .6),
    500: Color.fromRGBO(211, 175, 95, .5),
    600: Color.fromRGBO(211, 175, 95, .4),
    700: Color.fromRGBO(211, 175, 95, .3),
    800: Color.fromRGBO(211, 175, 95, 0.2),
    900: Color.fromRGBO(211, 175, 95, .1)
  };
  static const Map<int, Color> swatch = {
    50: Color.fromRGBO(42, 42, 42, .1),
    100: Color.fromRGBO(42, 42, 42, .2),
    200: Color.fromRGBO(42, 42, 42, .3),
    300: Color.fromRGBO(42, 42, 42, 0.4),
    400: Color.fromRGBO(42, 42, 42, .5),
    500: Color.fromRGBO(42, 42, 42, .6),
    600: Color.fromRGBO(42, 42, 42, .7),
    700: Color.fromRGBO(42, 42, 42, .8),
    800: Color.fromRGBO(42, 42, 42, .9),
    900: Color.fromRGBO(42, 42, 42, 1)
  };
  static final theme = ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
          focusColor: ColorSet.backgroundColor,
          focusedBorder: OutlineInputBorder(),
          border: OutlineInputBorder(),
          disabledBorder: OutlineInputBorder(),
          labelStyle: TextStyle(color: ColorSet.primaryColor)),
      colorScheme: const ColorScheme(
          primary: ColorSet.primaryColor,
          secondary: ColorSet.secondaryColor,
          surface: ColorSet.surfaceColor,
          background: ColorSet.backgroundColor,
          error: ColorSet.errorColor,
          onPrimary: ColorSet.onPrimaryColor,
          onSecondary: ColorSet.onSecondaryColor,
          onSurface: ColorSet.onSurfacesColor,
          onBackground: ColorSet.onBackgroundColor,
          onError: ColorSet.onErrorColor,
          brightness: Brightness.dark),
      brightness: Brightness.dark,
      primaryColor: const Color.fromRGBO(30, 30, 30, 1),
      primarySwatch: const MaterialColor(0xFF424242, ColorSet.swatch),
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      splashColor: const Color.fromRGBO(30, 30, 30, 1),
      shadowColor: const Color.fromRGBO(30, 30, 30, 1),
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: MaterialColor(0xFFD3AF5F, ColorSet.color)),
      fontFamily: 'Roboto',
      textTheme: TextTheme(
          headline1:
              const TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: GoogleFonts.robotoCondensed(
              textStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70)),
          bodyText1: GoogleFonts.robotoCondensed(
              textStyle: const TextStyle(fontSize: 15.0)),
          headline3: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 45.0,
              color: MaterialColor(0xFFD3AF5F, ColorSet.color)),
          button: const TextStyle(fontFamily: 'OpenSans'),
          subtitle1: GoogleFonts.robotoCondensed(),
          bodyText2: GoogleFonts.robotoCondensed(),
          headline5: GoogleFonts.robotoCondensed(
              textStyle: const TextStyle(
                  fontFamily: '', fontSize: 20.0, color: Colors.white70)),
          headline4: GoogleFonts.robotoCondensed(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(211, 175, 95, 1),
              elevation: 8,
              minimumSize: const Size(250, 60))));
}
